page 50014 "Property Purchase List"
{
    ApplicationArea = All;
    PageType = List;
    SourceTable = "Custom Sales Header";
    Editable = False;
    CardPageId = "Property Sale Card";


    layout
    {

        area(Content)
        {
            repeater(Control1)
            {
                field(No; Rec.No)
                {
                    Caption = 'Transaction No.';
                }

                field("Customer No"; Rec."Customer No")
                {

                }

                field(Posted; Rec.Posted)
                {

                }


            }
        }
    }
}