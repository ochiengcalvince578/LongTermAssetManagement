table 50016 "Repayment Schedule"
{

    fields
    {


        field(1; ProjectNo; Code[20]) { }

        field(2; No; Integer)
        {

        }

        field(3; UnitNo; Code[20]) { }

        field(4; "Total Amount"; Decimal) { }

        field(5; "Repayment Amount"; Decimal) { }

        field(6; "Principal"; Decimal) { }

        field(7; "Interest"; Decimal) { }


        field(8; "Repayment Date"; Date) { }

        field(9; "Repayed Amount"; Decimal) { }

        field(10; "Loan Balance"; Decimal) { }

        field(11; "Project Name"; Text[100]) { }

        field(12; "Customer No."; Code[20]) { }

        field(13; "Customer Name"; Text[100]) { }

        field(14; "Default Amount 1m"; Decimal) { }

        field(15; "Default Amount 2m"; Decimal) { }

        field(16; "Default Amount 3m"; Decimal) { }

        field(17; "Default Amount 3m+"; Decimal) { }

        field(18; "Amount in Default"; Decimal) { }
    }

    keys
    {

        key(PKey; ProjectNo, UnitNo, No)
        {

        }
    }

}