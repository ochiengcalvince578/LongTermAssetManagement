namespace DefaultPublisher;

page 50007 "Unit List"
{
    ApplicationArea = aLL;
    PageType = List;
    SourceTable = Unit;


    layout
    {

        area(Content)
        {

            repeater(Control1)
            {
                field(No; Rec.No)
                {

                }

                field(Type; Rec.Type)
                {

                }

                field("Unit No"; Rec."Unit No")
                {

                }

                field(Price; Rec.Price)
                {
                    Caption = 'Cost';
                }

                field("Water Charge"; Rec."Water Charge")
                {

                }

                field("Electricity Charge"; Rec."Electricity Charge")
                {

                }

                field("Service Charge"; Rec."Service Charge")
                {

                }

                field("Legal Expense"; Rec."Legal Expense")
                {

                }
            }
        }
    }

}