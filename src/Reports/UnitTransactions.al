Report 50025 "Unit Transactions"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/UnitTransactions.rdlc';


    dataset
    {
        dataitem(Unit; Unit)
        {
            column(No; No) { }

            column(Block_No; "Block No") { }


            column(Price; Price) { }

            column(Status; Status)
            { }

            column(Stage; Stage)
            {

            }

            column(Water_Charge; "Water Charge")
            {

            }

            column(Electricity_Charge; "Electricity Charge")
            {

            }

            column(Legal_Expense; "Legal Expense")
            {

            }

            column(Customer_No_; "Customer No.")
            {

            }

            column(Customer_Name; "Customer Name")
            {

            }

            column(Responsible_Person; "Responsible Person")
            {

            }

            column(Responsible_Person_No_; "Responsible Person No.")
            {
            }

            column(Project_Name; "Project Name")
            {

            }


            dataitem("Cust. Ledger Entry"; "Cust. Ledger Entry")
            {
                DataItemLink = "Unit No." = field(No);

                column(Debit_Amount; "Debit Amount") { }

                column(Posting_Date; "Posting Date") { }

                column(Credit_Amount; "Credit Amount") { }

                column(Description; Description) { }

                column(Document_No_; "Document No.") { }

            }


        }
    }

    var

        TotalDue: Decimal;
        TotalPaid: Decimal;
}