page 50024 "Unit Card"
{
    PageType = Card;
    SourceTable = Unit;
    Editable = false;


    layout
    {


        area(Content)
        {
            Group(General)
            {

                field("Block No"; Rec."Block No")
                {
                    Caption = 'Caption No.';
                }

                field(No; Rec.No)
                {
                    Caption = 'Unit No.';
                }

                field(Status; Rec.Status)
                {

                }

                field(Stage; Rec.Stage)
                {

                }



                field(Price; Rec.Price)
                {
                    Caption = 'Cost';
                }

            }


            Group(Charges)
            {
                field("Service Charge"; Rec."Service Charge")
                {

                }

                field("Legal Expense"; Rec."Legal Expense")
                {

                }

                field("Water Charge"; Rec."Water Charge")
                {

                }

                field("Electricity Charge"; Rec."Electricity Charge")
                {

                }
            }

            Group("Acquisiton Information")
            {
                field("Customer No."; Rec."Customer No.")
                {

                }

                field("Customer Name"; Rec."Customer Name")
                {

                }


                field("Responsible Person No."; Rec."Responsible Person No.")
                {

                }

                field("Responsible Person"; Rec."Responsible Person")
                {

                }
            }
        }
    }


    actions
    {
        area(Reporting)
        {
            action("Unit Transactions")
            {

                trigger OnAction()

                var
                    UnitRec: Record Unit;

                begin

                    UnitRec.Reset;
                    UnitRec.SetRange("Block No", rEC."Block No");
                    UnitRec.SetRange(No, Rec.No);

                    If UnitRec.FindFirst() then begin

                        //Report.Run()

                        Report.Run(50025, true, false, UnitRec);

                    end;
                end;


            }


            action("Charge Sheet")
            {

                trigger OnAction()

                BEGIN

                    Message('Coming soon')
                END;
            }
        }
    }
}