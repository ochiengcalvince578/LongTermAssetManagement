table 50017 "Employees Cue"
{

    fields
    {



        field(1; "User ID"; Code[50])
        {
            TableRelation = "User Setup"."User ID";
        }

        field(2; "All Employees"; Integer)
        {

            CalcFormula = count(Employee);
            FieldClass = FlowField;

        }

    }
}