page 50012 "Property Sale Card"
{
    ApplicationArea = All;
    SourceTable = "Custom Sales Header";
    PageType = Card;



    layout
    {
        area(Content)
        {

            group(General)
            {

                field(No; Rec.No) { }

                field("Purchase Option"; Rec."Purchase Option")
                { }

                field("Customer No"; Rec."Customer No")
                {

                }

                field("Customer Name"; Rec."Customer Name")
                {

                }

                field("Project No"; Rec."Project No")
                {

                }

                field("Project Name"; Rec."Project Name")
                {

                }

                field("Posting Date"; Rec."Posting Date")
                {

                }


            }


            part(Lines; "Custom Sales Lines")
            {

                ApplicationArea = Basic;
                SubPageLink = "Transaction No" = field(No);
            }

        }

    }


    actions
    {

        area(Processing)
        {
            action("Post")
            {
                Promoted = True;
                PromotedCategory = Process;
                ApplicationArea = All;

                trigger OnAction()

                begin

                    Rec.TestField("Customer No");
                    Rec.TestField("Project No");
                    Rec.TestField("Posting Date");

                    GeneralTemplateName := 'GENERAL';
                    DefaultBatchName := 'DEFAULT';


                    FnInsertLines();


                    GeneralJournalLines.Reset();
                    GeneralJournalLines.SetRange("Journal Template Name", GeneralTemplateName);
                    GeneralJournalLines.SetRange("Journal Batch Name", DefaultBatchName);


                    If GeneralJournalLines.FindSet() then begin
                        Codeunit.Run(Codeunit::"Gen. Jnl.-Post Batch", GeneralJournalLines);

                        Rec.Posted := true;
                        Rec.Modify();
                        Message('The lines were successfully posted.');

                    end



                end;

            }
        }

    }

    local procedure FnInsertLines()

    var

        GnJournalLine: Record "Gen. Journal Line";
        CustomerPostingGroup: Record "Customer Posting Group";
        ProjectRec: Record Block;
        SalesLines: Record "Custom Sales Lines";
        RecievablesAccount: Code[20];
        InventoryAccount: Code[20];
        LineNo: Integer;
    begin

        if CustomerPostingGroup.Get(Rec."Project No") then begin
            RecievablesAccount := CustomerPostingGroup."Receivables Account";
        end else begin
            Error('Posting had to stop. A Customer Posting Posting Group is missing.');
        end;


        ProjectRec.Reset();
        ProjectRec.SetRange(No, Rec."Project No");

        If ProjectRec.FindFirst() then begin

            If ProjectRec."Inventory Account" <> '' then begin

                InventoryAccount := ProjectRec."Inventory Account";
            end else begin

                Error('Posting had to stop. An Inventory G/L Account is missing');
            end;
        end else begin
            Error('Posting had to stop. We couldnt fetch the project record.');
        end;



        SalesLines.Reset();
        SalesLines.SetRange("Transaction No", rEC.No);

        If SalesLines.FindSet() then begin

            repeat
                //DEBIT RECEIVABLES

                LineNo := LineNo + 10000;

                GnJournalLine."Line No." := LineNo;
                GnJournalLine."Journal Template Name" := GeneralTemplateName;
                GnJournalLine."Journal Batch Name" := DefaultBatchName;
                GnJournalLine."Account Type" := GnJournalLine."Account Type"::"G/L Account";

                GnJournalLine."Account No." := RecievablesAccount;

                GnJournalLine.Description := SalesLines.Description;
                GnJournalLine."Document Date" := Rec."Posting Date";
                GnJournalLine."Posting Date" := Rec."Posting Date";
                GnJournalLine.Amount := SalesLines.Amount;

                GnJournalLine."Document Type" := GnJournalLine."Document Type"::" ";
                GnJournalLine."Document No." := Rec.No;


                GnJournalLine.Insert();

                //CREDIT INVENTORY

                LineNo := LineNo + 10000;

                GnJournalLine."Line No." := LineNo;
                GnJournalLine."Journal Template Name" := GeneralTemplateName;
                GnJournalLine."Journal Batch Name" := DefaultBatchName;
                GnJournalLine."Account Type" := GnJournalLine."Account Type"::"G/L Account";

                GnJournalLine."Account No." := InventoryAccount;

                GnJournalLine."Document Date" := Rec."Posting Date";
                GnJournalLine."Posting Date" := Rec."Posting Date";
                GnJournalLine.Amount := SalesLines.Amount * -1;


                GnJournalLine."Document Type" := GnJournalLine."Document Type"::" ";
                GnJournalLine."Document No." := Rec.No;

                GnJournalLine.Insert();

            until SalesLines.Next() = 0;

        end else begin

            Error('Posting had to stop. Unable to find sales lines attached to the document');

        end;


    end;


    var

        GeneralTemplateName: Text[50];
        DefaultBatchName: Text[50];
        GeneralJournalLines: Record "Gen. Journal Line";

    trigger OnOpenPage()
    begin

        Editable := not Rec.Posted;
    end;

}