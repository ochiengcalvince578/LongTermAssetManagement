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


    }

    keys
    {

        key(PKey; ProjectNo, UnitNo, No)
        {

        }
    }

}