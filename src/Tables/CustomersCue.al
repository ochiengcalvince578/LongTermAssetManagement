table 50014 "Customers Cue"
{

    fields
    {



        field(1; "User ID"; Code[50])
        {
            TableRelation = "User Setup"."User ID";
        }

        field(2; "All Customers"; Integer)
        {

            CalcFormula = count(Customer);
            FieldClass = FlowField;

        }

    }
}