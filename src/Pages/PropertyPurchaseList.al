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

                field("Customer Name"; Rec."Customer Name")
                {

                }

                field("Project No"; Rec."Project No")
                {

                }

                field("Project Name"; Rec."Project Name")
                {

                }

                field("Unit No."; Rec."Unit No.")
                {

                }

                field("Responsible Employee"; Rec."Responsible Employee")
                {

                }

                field("Responsible Employee Name"; Rec."Responsible Employee Name")
                {

                }

                field(Posted; Rec.Posted)
                {

                }


            }
        }
    }
}