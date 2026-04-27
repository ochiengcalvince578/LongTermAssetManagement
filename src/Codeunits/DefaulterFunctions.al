Codeunit 50022 "Defaulter Functions"
{

    trigger OnRun()

    begin

        RunDefaulterJob();
    end;


    var

        RepaymentSchedule: Record "Repayment Schedule";


    procedure RunDefaulterJob()

    var

        DaysDiff: Decimal;
        AmountDiff: Decimal;

    begin

        RepaymentSchedule.Reset();
        RepaymentSchedule.SetFilter("Repayment Date", '<=%1', Today);
        RepaymentSchedule.SetFilter("Repayed Amount", '<%1', RepaymentSchedule."Repayed Amount");

        If RepaymentSchedule.FindSet() then begin
            repeat

                RepaymentSchedule."Default Amount 1m" := 0;
                RepaymentSchedule."Default Amount 2m" := 0;
                RepaymentSchedule."Default Amount 3m" := 0;

                DaysDiff := Today - RepaymentSchedule."Repayment Date";

                AmountDiff := RepaymentSchedule."Repayment Amount" - RepaymentSchedule."Repayed Amount";

                RepaymentSchedule."Amount in Default" := AmountDiff;

                if DaysDiff <= 30 then
                    RepaymentSchedule."Default Amount 1m" := AmountDiff

                else if DaysDiff <= 60 then
                    RepaymentSchedule."Default Amount 2m" := AmountDiff

                else if DaysDiff <= 90 then
                    RepaymentSchedule."Default Amount 3m" := AmountDiff

                else
                    RepaymentSchedule."Default Amount 3m+" := AmountDiff;



                RepaymentSchedule.Modify();
            until RepaymentSchedule.Next() = 0;
        end;
    end;
}