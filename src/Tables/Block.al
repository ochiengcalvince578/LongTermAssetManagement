namespace DefaultPublisher;
using Microsoft.Sales.Customer;
using Microsoft.Foundation.NoSeries;
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

        field(13; "Three - Bedroom Cost"; Decimal)
        {

        }

        field(14; "Two - Bedroom Cost"; Decimal)
        {

        }

        field(15; "Townhouse Cost"; Decimal)
        {

        }

        field(16; "Three - Bedroom Units"; Decimal)
        {

        }

        field(17; "Two - Bedroom Units"; Decimal)
        {

        }


        field(18; "Townhouses"; Decimal)
        {

        }

        field(19; "Electricity Charge Townhouse"; Decimal)
        {

        }

        field(20; "Water Charge Townhouse"; Decimal)
        {

        }

        field(21; "Legal Charge Townhouse"; Decimal)
        {

        }

        field(22; "Electricity Charge 2b"; Decimal)
        {

        }

        field(23; "Water Charge 2b"; Decimal)
        {

        }


        field(24; "Legal Charge 2b"; Decimal)
        {

        }

        field(25; "Water Charge 3b"; Decimal)
        {

        }

        field(26; "Electricity Charge 3b"; Decimal)
        {

        }

        field(27; "Legal Charge 3b"; Decimal)
        {

        }


    }

    trigger OnInsert()
    begin

        No := NoSeriesMgmt.GetNextNo('BLOCK');
    end;

    var

        NoSeriesMgmt: Codeunit "No. Series";
        NoSeriesRec: Record "No. Series";

}