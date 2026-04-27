tableextension 50022 EmployeeExt extends Employee

{
    fields
    {

        field(5000; "Employee Category"; Option)
        {

            OptionMembers = "SalesPerson","Agent";

        }

        field(5001; "Employee Class"; Option)
        {
            OptionMembers = "Internal","External";
        }
    }
}
