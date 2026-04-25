Report 50016 "Repyament Schedule"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/RepaymentSchedule.rdlc';

    dataset
    {


        dataitem("Repayment Schedule"; "Repayment Schedule")
        {

            column(No; No) { }

            column(ProjectNo; ProjectNo) { }

            column(UnitNo; UnitNo) { }

            column(Loan_Balance; "Loan Balance") { }

            column(Repayment_Amount; "Repayment Amount") { }

            column(Principal; Principal) { }

            column(Interest; Interest) { }

            column(Repayed_Amount; "Repayed Amount") { }

            column(Repayment_Date; "Repayment Date") { }

            column(Project_Name; "Project Name") { }

            column(Customer_No_; "Customer No.") { }

            column(Customer_Name; "Customer Name") { }

        }
    }


}