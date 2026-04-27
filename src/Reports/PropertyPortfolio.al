Report 50023 "Property Portfolio"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/PropertyPortfolio.rdlc';


    dataset
    {

        dataitem(Block; Block)
        {

            RequestFilterFields = No;

            column(No; No) { }

            column(Description; Description) { }



            dataitem(Unit; Unit)
            {
                DataItemLink = "Block No" = field(No);

                column(UnitNo; No) { }

                column(Customer_No_; "Customer No.") { }

                column(Customer_Name; "Customer Name") { }

                column(TotalPaid; TotalPaid) { }

                column(TotalDue; TotalDue) { }

                column(Balance; Balance) { }


                trigger OnAfterGetRecord()

                var

                    UnitRec: Record Unit;
                    CustLedgerEntries: Record "Cust. Ledger Entry";

                begin

                    TotalPaid := 0;
                    TotalDue := 0;

                    CustLedgerEntries.Reset();

                    CustLedgerEntries.SetRange("Customer No.", Unit."Customer No.");
                    CustLedgerEntries.SetRange("Project No.", UNIT."Block No");
                    CustLedgerEntries.SetRange("Unit No.", Unit.No);

                    CustLedgerEntries.CalcFields("Debit Amount", "Credit Amount");

                    TotalDue := CustLedgerEntries."Debit Amount";
                    TotalPaid := CustLedgerEntries."Credit Amount";

                    Balance := TotalDue - TotalPaid;
                end;


            }

        }
    }


    var

        TotalPaid: Decimal;

        TotalDue: Decimal;

        Balance: Decimal;
}