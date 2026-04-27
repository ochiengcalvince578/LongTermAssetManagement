pageextension 50023 "Employee Card Extension" extends "Employee Card"
{
    layout
    {

        modify("Social Security No.")
        {
            Visible = false;
        }

        addafter("Collective Bargain. Agmt. Info")
        {
            field("Employee Category"; Rec."Employee Category")
            {

            }

            field("Employee Class"; Rec."Employee Class")
            {

            }
        }
    }
}