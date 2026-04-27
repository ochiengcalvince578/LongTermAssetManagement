Report 50021 "Defaulter List"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/DefaultersList.rdlc';

    dataset
    {

        dataitem("Repayment Schedule"; "Repayment Schedule")
        {

            column(No; No) { }

            column(UnitNo; UnitNo) { }

            column(ProjectNo; ProjectNo) { }

            column(Customer_No_; "Customer No.") { }

            column(Customer_Name; "Customer Name") { }

            column(Amount_in_Default; "Amount in Default")
            {

            }

            // trigger OnAfterGetRecord()

            // var

            //     RepaymentSchedule: Record "Repayment Schedule";

            // begin

            //     //  RepaymentSchedule

            //     RepaymentSchedule.Reset();
            //     RepaymentSchedule.SetFilter("Amount in Default", '>0');

            //     I

            // end;

        }

    }


    var

        AmountInArrears: Decimal;

        ProjectNo: Code[20];

        UnitNo: Code[20];

}