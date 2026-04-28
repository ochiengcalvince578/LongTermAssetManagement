page 50027 "Custom Customer List"
{
    PageType = List;

    CardPageId = "Custom Customer";

    SourceTable = Customer;


    layout
    {


        area(Content)
        {

            repeater(Control1)
            {
                field("No."; Rec."No.")
                {

                }


                field(Name; Rec.Name)
                {

                }

                field("Mobile Phone No."; Rec."Mobile Phone No.")
                {

                }

                field("E-Mail"; Rec."E-Mail")
                {

                }
            }
        }
    }

}