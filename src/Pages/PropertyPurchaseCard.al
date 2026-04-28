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

                field(No; Rec.No)
                {

                }

                field("Purchase Option"; Rec."Purchase Option")
                {

                }

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



                field("Unit No."; Rec."Unit No.")
                {

                }




                field("Responsible Employee"; Rec."Responsible Employee")
                {

                }

                field("Responsible Employee Name"; Rec."Responsible Employee Name")

                {

                }

                field("Bank Account Code"; Rec."Bank Account Code")
                {

                }

                field("Bank Account Name"; Rec."Bank Account Name")
                {
                    Editable = false;
                }

                field("Posting Date"; Rec."Posting Date")
                {

                }


            }

            group("Loan Details")
            {

                field("Interest Rate"; Rec."Interest Rate")
                {

                }

                field("Repayment Period"; Rec."Repayment Period")
                {

                }

                field(Installments; Rec.Installments)
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
                Enabled = not Rec.Posted;

                trigger OnAction()

                var

                    LoanAmount: Decimal;
                    UnitRec: Record Unit;
                begin

                    Rec.TestField("Customer No");
                    Rec.TestField("Project No");
                    Rec.TestField("Unit No.");
                    Rec.TestField("Posting Date");
                    Rec.TestField("Bank Account Code");
                    Rec.TestField("Responsible Employee");

                    GeneralTemplateName := 'GENERAL';
                    DefaultBatchName := 'DEFAULT';


                    if Rec."Purchase Option" = Rec."Purchase Option"::"Rent To Own" then begin
                        //LoanAmount := Rec. 
                        //FnCreatePaymentSchedule();

                        FnInsertRentToOwnLines();
                        GeneralJournalHelper(UnitRec.Status::Active);
                    end else if Rec."Purchase Option" = Rec."Purchase Option"::"Cash Deposit" then begin

                        //FnInsertCashDepositLines
                        //GeneralJournalHelper(UnitRec.Status::Active);
                    end else if Rec."Purchase Option" = Rec."Purchase Option"::"Outright Sale" then begin
                        FnInsertLines();
                        GeneralJournalHelper(UnitRec.Status::Complete);

                    end;

                end;

            }
        }

        area(Reporting)
        {

            action("Loan Schedule")
            {
                Promoted = True;
                PromotedCategory = Report;
                ApplicationArea = All;

                trigger OnAction()
                var

                    ProjectRec: Record Block;
                    UnitRec: Record Unit;
                    LoanScheduleRec: Record "Repayment Schedule";

                begin

                    LoanScheduleRec.Reset();

                    LoanScheduleRec.SetRange(ProjectNo, Rec."Project No");
                    LoanScheduleRec.SetRange(UnitNo, Rec."Unit No.");

                    if LoanScheduleRec.FindFirst() then
                        Report.Run(50016, true, false, LoanScheduleRec);
                end;

            }

        }

    }

    local procedure FnCashDepositLines()

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

    end;

    local procedure FnInsertLines()

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
                //DEBIT A BANK ACCOOUNT

                LineNo := LineNo + 10000;

                GnJournalLine."Line No." := LineNo;
                GnJournalLine."Journal Template Name" := GeneralTemplateName;
                GnJournalLine."Journal Batch Name" := DefaultBatchName;
                GnJournalLine."Account Type" := GnJournalLine."Account Type"::"Bank Account";

                GnJournalLine."Account No." := Rec."Bank Account Code";

                GnJournalLine.Description := SalesLines.Description;
                GnJournalLine."Document Date" := Rec."Posting Date";
                GnJournalLine."Posting Date" := Rec."Posting Date";
                GnJournalLine.Amount := SalesLines.Amount;

                GnJournalLine."Document Type" := GnJournalLine."Document Type"::" ";
                GnJournalLine."Document No." := Rec.No;


                //  GnJournalLine."Project No." := rEC."Project No";
                //GnJournalLine."Unit No." := Rec."Unit No.";



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


                GnJournalLine."Project No." := rEC."Project No";
                GnJournalLine."Unit No." := Rec."Unit No.";


                GnJournalLine.Insert();

            until SalesLines.Next() = 0;

        end else begin

            Error('Posting had to stop. Unable to find sales lines attached to the document');

        end;


    end;


    local procedure FnInsertRentToOwnLines()

    var
        LoanAmount: Decimal;
        UnitRec99: Record Unit;
    begin

        Rec.TestField("Interest Rate");
        //  Rec.TestField("Repayment Period");
        Rec.TestField(Installments);

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


            UnitRec99.Reset();
            UnitRec99.SetRange("Block No", Rec."Project No");
            UnitRec99.SetRange(No, Rec."Unit No.");


            if UnitRec99.FindFirst() then begin

                LoanAmount := UnitRec99.Price * 0.75;

                FnCreatePaymentSchedule(LoanAmount, Rec.Installments, Rec."Interest Rate", ProjectRec.No, Rec."Unit No.", Rec."Posting Date", Rec."Project Name", Rec."Customer No", Rec."Customer Name");

            end;

        end else begin
            Error('Posting had to stop. We couldnt fetch the project record.');
        end;


        GnJournalLine.Reset();

        GnJournalLine.SetRange("Journal Template Name", 'GENERAL');
        GnJournalLine.SetRange("Journal Batch Name", 'DEFAULT');

        If GnJournalLine.FindSet() then
            GnJournalLine.DeleteAll();


        SalesLines.Reset();
        SalesLines.SetRange("Transaction No", rEC.No);

        If SalesLines.FindSet() then begin

            repeat

                // DEBIT 25% TO THE BANK

                LineNo := LineNo + 10000;

                GnJournalLine."Line No." := LineNo;
                GnJournalLine."Journal Template Name" := GeneralTemplateName;
                GnJournalLine."Journal Batch Name" := DefaultBatchName;
                GnJournalLine."Account Type" := GnJournalLine."Account Type"::"Bank Account";

                GnJournalLine."Account No." := Rec."Bank Account Code";

                GnJournalLine.Description := SalesLines.Description;
                GnJournalLine."Document Date" := Rec."Posting Date";
                GnJournalLine."Posting Date" := Rec."Posting Date";
                GnJournalLine.Amount := (0.25 * SalesLines.Amount);

                GnJournalLine."Document Type" := GnJournalLine."Document Type"::" ";
                GnJournalLine."Document No." := Rec.No;


                GnJournalLine.Insert();


                //CREDIT 25% TO THE INVENTORY

                LineNo := LineNo + 10000;

                GnJournalLine."Line No." := LineNo;
                GnJournalLine."Journal Template Name" := GeneralTemplateName;
                GnJournalLine."Journal Batch Name" := DefaultBatchName;
                GnJournalLine."Account Type" := GnJournalLine."Account Type"::"G/L Account";

                GnJournalLine."Account No." := InventoryAccount;

                GnJournalLine."Document Date" := Rec."Posting Date";
                GnJournalLine."Posting Date" := Rec."Posting Date";
                GnJournalLine.Amount := (0.25 * SalesLines.Amount) * -1;


                GnJournalLine."Document Type" := GnJournalLine."Document Type"::" ";
                GnJournalLine."Document No." := Rec.No;


                GnJournalLine."Project No." := rEC."Project No";
                GnJournalLine."Unit No." := Rec."Unit No.";


                GnJournalLine.Insert();



                // DEBIT 75% TO THE RECEIVABLES

                LineNo := LineNo + 10000;

                GnJournalLine."Line No." := LineNo;
                GnJournalLine."Journal Template Name" := GeneralTemplateName;
                GnJournalLine."Journal Batch Name" := DefaultBatchName;
                GnJournalLine."Account Type" := GnJournalLine."Account Type"::"G/L Account";

                GnJournalLine."Account No." := RecievablesAccount;

                GnJournalLine.Description := SalesLines.Description;
                GnJournalLine."Document Date" := Rec."Posting Date";
                GnJournalLine."Posting Date" := Rec."Posting Date";
                GnJournalLine.Amount := (0.75 * SalesLines.Amount);

                GnJournalLine."Document Type" := GnJournalLine."Document Type"::" ";
                GnJournalLine."Document No." := Rec.No;




                GnJournalLine."Project No." := rEC."Project No";
                GnJournalLine."Unit No." := Rec."Unit No.";


                GnJournalLine.Insert();


                // CREDIT 75% TO THE INVENTORY

                LineNo := LineNo + 10000;

                GnJournalLine."Line No." := LineNo;
                GnJournalLine."Journal Template Name" := GeneralTemplateName;
                GnJournalLine."Journal Batch Name" := DefaultBatchName;
                GnJournalLine."Account Type" := GnJournalLine."Account Type"::"G/L Account";

                GnJournalLine."Account No." := RecievablesAccount;

                GnJournalLine.Description := SalesLines.Description;
                GnJournalLine."Document Date" := Rec."Posting Date";
                GnJournalLine."Posting Date" := Rec."Posting Date";
                GnJournalLine.Amount := (0.75 * SalesLines.Amount) * -1;

                GnJournalLine."Document Type" := GnJournalLine."Document Type"::" ";
                GnJournalLine."Document No." := Rec.No;

                GnJournalLine.Insert();

            until SalesLines.Next() = 0;

        end;

    end;


    local procedure FnCreatePaymentSchedule(LoanAmount: Decimal; Installments: Integer; InterestRate: Decimal; ProjectCode: Code[20]; UnitCode: Code[20]; RepaymentStartDate: Date; Projectname: Text[100]; CustomerNo: Code[20]; CustomerName: Text[100])

    var

        ScheduleRec: Record "Repayment Schedule";
        i: Integer;
        InterestRatePerPeriod: Decimal;

        //power calculation
        Power: Decimal;
        Base: Decimal;
        Result: Decimal;
        Repayment: Decimal;
        Principal: Decimal;
        Interest: Decimal;
        Balance: Decimal;

        RepaymentDate: Date;

        EMI: Decimal;


    begin

        InterestRatePerPeriod := InterestRate / 12 / 100;
        Balance := LoanAmount;

        Power := 1;

        // Compute (1+r)^n
        for i := 1 to Installments do
            Power := Power * (1 + InterestRatePerPeriod);

        // EMI = P * r(1+r)^n / ((1+r)^n - 1)
        EMI := LoanAmount * (InterestRatePerPeriod * (Power)) / (Power - 1);

        RepaymentDate := RepaymentStartDate;

        for i := 1 to Installments do begin

            // Assuming RepaymentPeriod is Monthly
            RepaymentDate := CalcDate('1M', RepaymentDate);

            Interest := (InterestRatePerPeriod * Balance);

            Principal := EMI - Interest;

            Balance := Balance - Principal;

            if i = Installments then begin
                Principal := Principal + Balance;
                Balance := 0;
            end;

            //Init a Schedule record
            ScheduleRec.Init;
            ScheduleRec."Customer No." := CustomerNo;
            ScheduleRec."Customer Name" := CustomerName;
            ScheduleRec.ProjectNo := ProjectCode;
            ScheduleRec."Project Name" := Projectname;
            ScheduleRec.UnitNo := UnitCode;
            ScheduleRec.No := i;

            ScheduleRec."Repayment Amount" := Round(EMI, 1, '>');
            ScheduleRec.Interest := Round(Interest, 1, '>');
            ScheduleRec.Principal := Round(Principal, 1, '>');
            ScheduleRec."Loan Balance" := Round(Balance, 1, '>');
            ScheduleRec."Repayment Date" := RepaymentDate;

            ScheduleRec.Insert();
        end;
    end;


    local procedure GeneralJournalHelper(Status: Option)

    var

        UnitRec: Record Unit;

    begin

        GeneralJournalLines.Reset();
        GeneralJournalLines.SetRange("Journal Template Name", 'GENERAL');
        GeneralJournalLines.SetRange("Journal Batch Name", 'DEFAULT');


        If GeneralJournalLines.FindSet() then begin
            Codeunit.Run(Codeunit::"Gen. Jnl.-Post Batch", GeneralJournalLines);

            Rec.Posted := true;
            Rec.Modify();


            If UnitRec.Get(Rec."Unit No.", Rec."Project No") then begin
                UnitRec.Status := Status;

                UnitRec."Customer No." := Rec."Customer No";
                UnitRec."Customer Name" := Rec."Customer Name";
                UnitRec."Responsible Person No." := Rec."Responsible Employee";
                UnitRec."Responsible Person" := Rec."Responsible Employee Name";

                UnitRec.Modify();
            end else begin

                Message('The target unit was not found')
            end;

            Message('The lines were successfully posted.');

        end
    end;

    var

        GeneralTemplateName: Text[50];
        DefaultBatchName: Text[50];
        GeneralJournalLines: Record "Gen. Journal Line";


        GnJournalLine: Record "Gen. Journal Line";
        CustomerPostingGroup: Record "Customer Posting Group";
        ProjectRec: Record Block;
        SalesLines: Record "Custom Sales Lines";
        RecievablesAccount: Code[20];
        InventoryAccount: Code[20];
        LineNo: Integer;

    trigger OnOpenPage()
    begin

        Editable := not Rec.Posted;
    end;

}