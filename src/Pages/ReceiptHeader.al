page 50021 "Receipt Header"
{
    ApplicationArea = Basic;
    PageType = "Card";
    SourceTable = "Receipt Header";


    Layout
    {

        area(Content)
        {

            group(General)
            {

                field("No."; Rec."No.")
                {

                }

                field("Customer No."; Rec."Customer No.")
                {

                }

                field("Customer Name"; Rec."Customer Name")
                {

                    Editable = false;

                }

                field(Amount; Rec.Amount)
                {

                }

                field(Reference; Rec.Reference)
                {

                }

                field("Bank Account No"; Rec."Bank Account No")
                {

                }

                field("Posting Date"; Rec."Posting Date")
                {

                }

            }


            part(Lines; "Receipt Lines")
            {
                ApplicationArea = Basic;
                SubPageLink = "Transaction No." = field("No.");
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
                Enabled = not Rec.Posted;

                trigger OnAction()

                Var

                    ReceiptLinesRec: Record "Receipt Lines";
                    ReceiptHeaderRec: Record "Receipt Header";
                    ReceiptLinesTotal: Decimal;
                    InstallmentBalance: Decimal;
                    ReceiptLineBalance: Decimal;
                    AmountToPay: Decimal;


                begin


                    Rec.TestField(Amount);
                    Rec.TestField("Posting Date");
                    Rec.TestField(Reference);


                    ReceiptLinesRec.Reset();

                    ReceiptLinesRec.SetRange("Transaction No.", Rec."No.");

                    ReceiptLinesTotal := 0;

                    If ReceiptLinesRec.FindSet() then begin
                        ReceiptLinesTotal := ReceiptLinesTotal + ReceiptLinesRec.Amount;
                    end;

                    If (Rec.Amount <> ReceiptLinesTotal) then
                        Error('The total amount in the receipt lines must equal the header amount');


                    InsertReceiptLines();

                    GenJournalLine.Reset;
                    GenJournalLine.SetRange("Journal Template Name", 'GENERAL');
                    GenJournalLine.SetRange("Journal Batch Name", 'DEFAULT');


                    If GenJournalLine.FindSet() then begin

                        Codeunit.Run(Codeunit::"Gen. Jnl.-Post Batch", GenJournalLine);

                        Rec.Posted := true;
                        Rec.Modify();


                        //Assuming Customers are only ever paying towards the housing

                        ReceiptHeaderRec.Reset();
                        ReceiptHeaderRec.SetRange("No.", Rec."No.");
                        ReceiptHeaderRec.SetRange(Posted, true);

                        If ReceiptHeaderRec.FindFirst() then begin

                            ReceiptLinesRec.Reset();

                            ReceiptLinesRec.SetRange("Transaction No.", ReceiptHeaderRec."No.");

                            If ReceiptLinesRec.FindSet() then begin
                                repeat

                                    ReceiptLineBalance := ReceiptLinesRec.Amount;

                                    LoanSheduleRec.Reset();
                                    LoanSheduleRec.SetRange(ProjectNo, ReceiptLinesRec."Project No.");
                                    LoanSheduleRec.SetRange(UnitNo, ReceiptLinesRec."Unit No.");

                                    if LoanSheduleRec.FindSet() then begin

                                        repeat

                                            If LoanSheduleRec."Repayed Amount" < LoanSheduleRec."Repayment Amount" then begin

                                                InstallmentBalance := LoanSheduleRec."Repayment Amount" - LoanSheduleRec."Repayed Amount";

                                                if ReceiptLineBalance > InstallmentBalance then begin
                                                    AmountToPay := InstallmentBalance;
                                                end else begin

                                                    AmountToPay := ReceiptLineBalance;
                                                end;
                                                ReceiptLineBalance := ReceiptLineBalance - AmountToPay;
                                                LoanSheduleRec."Repayed Amount" += AmountToPay;
                                                LoanSheduleRec.Modify();
                                            end;


                                        until LoanSheduleRec.Next() = 0; // or until Line balance is 0
                                    end;

                                until ReceiptLinesRec.Next() = 0;
                            end

                        end;

                        //LoanScheduleRec.SetRange();

                        Message('Receipt posted successfully');

                    end;



                end;

            }
        }



    }


    local procedure InsertReceiptLines()

    var

        LineNo: Integer;
        ReceiptLines2: Record "Receipt Lines";

    begin


        GenJournalLine.Reset();

        GenJournalLine.SetRange("Journal Template Name", 'GENERAL');
        GenJournalLine.SetRange("Journal Batch Name", 'DEFAULT');

        If GenJournalLine.FindSET() then
            GenJournalLine.DeleteAll();

        //insert bank debit lump
        LineNo := LineNo + 10000;

        GenJournalLine.Init;
        GenJournalLine."Line No." := LineNo;
        GenJournalLine."Journal Template Name" := 'GENERAL';
        GenJournalLine."Journal Batch Name" := 'DEFAULT';
        GenJournalLine.Amount := Rec.Amount;
        GenJournalLine."Account Type" := GenJournalLine."Account Type"::"Bank Account";
        GenJournalLine."Account No." := Rec."Bank Account No";
        //GenJournalLine.Description := ReceiptLines2.Description;
        GenJournalLine."Document Type" := GenJournalLine."Document Type"::" ";
        GenJournalLine."Posting Date" := Rec."Posting Date";

        GenJournalLine."Document No." := rec."No.";
        GenJournalLine."Document Date" := rEC."Posting Date";


        GenJournalLine.Insert();


        ReceiptLines2.Reset();
        ReceiptLines2.SetRange("Transaction No.", Rec."No.");

        If ReceiptLines2.FindSet() then begin

            LineNo := LineNo + 10000;


            GenJournalLine.Init;
            GenJournalLine."Line No." := LineNo;
            GenJournalLine."Journal Template Name" := 'GENERAL';
            GenJournalLine."Journal Batch Name" := 'DEFAULT';
            GenJournalLine.Amount := ReceiptLines2.Amount * -1;
            GenJournalLine."Account Type" := GenJournalLine."Account Type"::Customer;
            GenJournalLine."Account No." := ReceiptLines2."Account No.";
            GenJournalLine.Description := ReceiptLines2.Description;
            GenJournalLine."Document Type" := GenJournalLine."Document Type"::" ";
            GenJournalLine."Posting Date" := Rec."Posting Date";
            GenJournalLine."Document Date" := rEC."Posting Date";

            GenJournalLine."Document No." := rec."No.";

            GenJournalLine."Project No." := ReceiptLines2."Project No.";
            GenJournalLine."Unit No." := ReceiptLines2."Unit No.";

            GenJournalLine.Insert();
        end;

    end;


    var
        GenJournalLine: Record "Gen. Journal Line";

        LoanSheduleRec: Record "Repayment Schedule";


    trigger OnOpenPage()
    begin

        Editable := not Rec.Posted;
    end;

}