namespace DefaultPublisher;

page 50004 "Block Card"
{

    ApplicationArea = Suite;
    Caption = 'Housing Card';
    SourceTable = Block;

    layout
    {

        area(content)
        {

            group(General)

            {

                field(No; Rec.No)
                {

                }

                field(Description; Rec.Description)
                {

                }

                field(Location; Rec.Location)
                {

                }

                field(Units; Rec.Units)
                {

                }

            }

            group("Unit Information")
            {
                field("Unit Cost"; Rec."Unit Cost")
                {

                }

                field("Electricity Charge Per Unit"; Rec."Electricity Charge Per Unit")
                {

                }

                field("Water Charge Per Unit"; Rec."Water Charge Per Unit")
                {

                }


                field("Service Charge Per Unit"; Rec."Service Charge Per Unit")
                {

                }

                field("Legal Expense Per Unit"; Rec."Legal Expense Per Unit")
                {

                }
            }


            group("General Ledger Setup")
            {

                field("Inventory Account"; Rec."Inventory Account")
                {

                    ShowMandatory = true;

                }

                field("Customer Posting Group"; Rec."Customer Posting Group")
                {

                    ShowMandatory = true;

                }

                field("Income Account"; Rec."Income Account")
                {

                    ShowMandatory = true;

                }
            }
        }
    }


    actions
    {


        area(Processing)
        {

            action("Generate Units")
            {

                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()

                var

                begin


                    GenerateUnits();


                end;

            }


        }
    }


    local procedure GenerateUnits()

    VAR
        uNIT: rECORD uNIT;
        Blocks: Record Block;
        i: Integer;

    begin


        for i := 1 to Rec.Units do begin

            uNIT.Init();

            Unit.No := Format(i);
            Unit.Price := REC."Unit Cost";
            Unit."Electricity Charge" := rEC."Electricity Charge Per Unit";
            //Unit."Unit No" :=  
            Unit."Water Charge" := rEC."Water Charge Per Unit";
            Unit."Service Charge" := Rec."Service Charge Per Unit";

            uNIT."Legal Expense" := Rec."Legal Expense Per Unit";

            Unit.Insert();

        end;

    end;

}

