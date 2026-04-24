namespace DefaultPublisher;

page 50006 "Block List"
{

    ApplicationArea = ALL;
    SourceTable = Block;
    CardPageId = "Block Card";
    PageType = list;

    layout
    {
        area(Content)
        {

            repeater(Control1)
            {
                field(No; Rec.No)
                {

                }

                field(Description; Rec.Description)
                {

                }

                field(Units; Rec.Units)
                {
                    Caption = 'No of Units';
                }

                field("Unit Cost"; Rec."Unit Cost")
                {

                }
            }
        }
    }

}