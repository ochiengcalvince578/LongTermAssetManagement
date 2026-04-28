namespace DefaultPublisher;

page 50007 "Unit List"
{
    ApplicationArea = aLL;
    PageType = List;
    CardPageId = "Unit Card";
    SourceTable = Unit;


    layout
    {

        area(Content)
        {

            repeater(Control1)
            {

                field("Block No"; Rec."Block No")
                {
                    Editable = false;

                }

                field("Unit No"; Rec.No)
                {
                    Editable = false;

                }

                field(Type; Rec.Type)
                {
                    Editable = false;


                }

                // field("Unit No"; Rec."Unit No")
                // {

                // }

                field(Price; Rec.Price)
                {
                    Caption = 'Cost';
                    Editable = false;

                }

                field("Water Charge"; Rec."Water Charge")
                {
                    Editable = false;

                }

                field("Electricity Charge"; Rec."Electricity Charge")
                {
                    Editable = false;

                }

                field("Service Charge"; Rec."Service Charge")
                {
                    Editable = false;

                }

                field("Legal Expense"; Rec."Legal Expense")
                {
                    Editable = false;

                }

                field("Customer No."; Rec."Customer No.")
                {
                    Editable = false;
                }

                field("Customer Name"; Rec."Customer Name")
                {
                    Editable = false;

                }

                field("Responsible Person"; Rec."Responsible Person")
                {
                    Editable = false;

                }

                field("Responsible Person No."; Rec."Responsible Person No.")
                {
                    Editable = false;

                }
            }
        }
    }

}