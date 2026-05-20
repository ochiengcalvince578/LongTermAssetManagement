page 50026 "Custom Customer"
{
    PageType = Card;
    SourceTable = Customer;

    layout
    {


        area(Content)
        {

            group(General)
            {
                field("No."; Rec."No.") { }

                field(Name; Rec.Name) { }

                field("Mobile Phone No."; Rec."Mobile Phone No.") { }

                field("E-Mail"; Rec."E-Mail") { }


            }


            group("Legal Information")
            {

                field("Id No."; Rec."Id No.")
                {

                }


                field("Passport No."; Rec."Passport No.")
                {

                }

                field(IdentityDocFront; Rec.IdentityDocFront)
                {
                    Caption = 'Id Doc Front';

                }

                field(IdentityCardBack; Rec.IdentityDocBack)
                {
                    Caption = 'Id Doc Back';
                }



                field("KRA Pin"; Rec."KRA Pin")
                {

                }
                field(KRAPinDoc; Rec.KRAPinDoc)
                {

                }

            }


            group("Financial Information")
            {
                field("ATM No."; Rec."ATM No.")
                {

                }

                field(AtmDoc; Rec.AtmDoc)
                {



                }
            }


            group("General Ledger Setup")
            {
                field("Customer Posting Group"; Rec."Customer Posting Group")
                {

                }
            }
        }


        area(factboxes)
        {
            part(Control149; "Customer Picture")
            {
                ApplicationArea = Basic, Suite;
                SubPageLink = "No." = field("No.");
                Visible = true;
                //   Visible = not IsOfficeAddin;
            }

            part("Attached Documents"; "Document Attachment Factbox")
            {
                ObsoleteTag = '25.0';
                ObsoleteState = Pending;
                ObsoleteReason = 'The "Document Attachment FactBox" has been replaced by "Doc. Attachment List Factbox", which supports multiple files upload.';
                ApplicationArea = All;
                Visible = false;
                Caption = 'Attachments';
                SubPageLink = "Table ID" = const(Database::Customer),
                              "No." = field("No.");
            }

            part("Attached Documents List"; "Doc. Attachment List Factbox")
            {
                ApplicationArea = All;
                Caption = 'Documents';
                UpdatePropagation = Both;
                SubPageLink = "Table ID" = const(Database::Customer),
                              "No." = field("No.");
            }

            part(Control39; "CRM Statistics FactBox")
            {
                ApplicationArea = All;
                SubPageLink = "No." = field("No.");
                //Visible = CRMIsCoupledToRecord;
                Visible = false;
            }


            part(WorkflowStatus; "Workflow Status FactBox")
            {
                ApplicationArea = Suite;
                Editable = false;
                Enabled = false;
                ShowFilter = false;
                //Visible = ShowWorkflowStatus;
                Visible = false;
            }

        }
    }


    actions
    {
        area(Reporting)
        {

            action("Customer Transactions")
            {
                trigger onAction()

                var

                    CustomerRec: Record Customer;


                begin

                    Message('Coming Soon');

                end;
            }

            action("Charge Sheet")
            {
                trigger OnAction()

                begin

                    Message('Coming Soon');
                end;
            }

            action("Payment Schedules")
            {
                trigger OnAction()

                begin

                    Message('Coming soon');
                end;
            }
        }
    }
}