namespace DefaultPublisher;
using Microsoft.Sales.Customer;
using Microsoft.Finance.GeneralLedger.Account;

table 50003 Block
{

    fields
    {

        field(1; "No"; Code[20])
        {

        }

        field(2; Description; Text[50])

        {

        }

        field(3; Location; Text[50])
        {

        }

        field(4; Units; Integer)
        {


        }


        field(5; "Customer Posting Group"; Code[30])
        {

            TableRelation = "Customer Posting Group";
        }

        field(6; "Inventory Account"; Code[30])
        {
            TableRelation = "G/L Account";
        }

        field(7; "Income Account"; Code[30])

        {
            TableRelation = "G/L Account";
        }

        field(8; "Unit Cost"; Decimal)
        {

            trigger OnValidate()
            begin

                "Water Charge Per Unit" := 0.01 * "Unit Cost";
            end;

        }

        field(9; "Water Charge Per Unit"; Decimal)
        {

            Editable = false;

        }

        field(10; "Electricity Charge Per Unit"; Decimal)
        {

        }

        field(11; "Legal Expense Per Unit"; Decimal)
        {

        }

        field(12; "Service Charge Per Unit"; Decimal)
        {

        }


    }

}