Page 50008 "Main Role Center"
{
    Caption = 'SalesPerson';
    PageType = RoleCenter;

    layout
    {
        area(RoleCenter)
        {

            part("Customers1"; "Customers Cue")
            {

                ApplicationArea = Basic, Suite;
                Visible = true;
                Caption = 'Customers';

            }

            part("Employees"; "Employees Cue")
            {

                ApplicationArea = Basic, Suite;
                Visible = true;
                Caption = 'Employees';

            }

            // part(Control99; "Finance Performance")
            // {
            //     ApplicationArea = Basic, Suite;
            //     Visible = false;
            // }

            part(Control1907692008; "My Accounts")
            {
                ApplicationArea = Basic, Suite;
                Visible = false;
            }

            part("Emails"; "Email Activities")
            {
                ApplicationArea = Basic, Suite;
                Visible = true;
            }

            part(Control103; "Trailing Sales Orders Chart")
            {
                ApplicationArea = Basic, Suite;
                Visible = false;
            }

            part(Control106; "My Job Queue")
            {
                ApplicationArea = Basic, Suite;
                Visible = false;
            }
            part(Control9; "Help And Chart Wrapper")
            {
                ApplicationArea = Basic, Suite;
                Visible = false;
            }
            part(Control100; "Cash Flow Forecast Chart")
            {
                ApplicationArea = Basic, Suite;
                Visible = false;
            }

        }

    }

    actions
    {

        area(sections)
        {

            group("System Management")
            {
                action("General Setup")
                {
                    RunObject = Page "General Setup";
                }

                action("No. Series")
                {
                    RunObject = page "No. Series";
                }
            }

            group("Customer Management")
            {
                action("Customers")
                {
                    Caption = 'Customers';
                    RunObject = Page "Customer List";

                }

            }

            group("Employee Management")
            {
                action("Employees1")
                {
                    Caption = 'Employees';
                    RunObject = Page "Employee List"
;
                }
            }

            group("Finance Management")
            {

                Group("Receipt Processing")
                {

                    action("Receipt List")
                    {
                        ApplicationArea = Basic, Suite;
                        Image = Receipt;
                        RunObject = page "Receipt List";
                        RunPageView = where(Posted = const(false));
                    }

                    action("Posted Receipt List")
                    {
                        ApplicationArea = Basic, Suite;
                        RunObject = page "Receipt List";
                        RunPageView = where(Posted = const(true));
                    }

                }



                action("General Journals")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'General Journals';
                    Image = Journal;
                    RunObject = Page "General Journal";//"General Journal Batches";
                    // RunPageView = where("Journal Template Name" = const('GENERAL'), "Template Type" = const(General), Recurring = const(false));
                    ToolTip = 'Post financial transactions directly to general ledger accounts and other accounts, such as bank, customer, vendor, and employee accounts. Posting with a general journal always creates entries on general ledger accounts. This is true even when, for example, you post a journal line to a customer account, because an entry is posted to a general ledger receivables account through a posting group.';
                }

                group("General Ledger")
                {
                    Caption = 'General Ledger and General Journals';
                    ToolTip = 'Process incoming and outgoing payments. Set up bank accounts and service connections for electronic banking.  ';
                    Visible = true;

                    action("G/L Register")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'G/L Register';
                        Image = Journal;
                        RunObject = Page "G/L Registers";
                    }

                    action("Chart of Accounts")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Chart of Accounts';
                        RunObject = Page "Chart of Accounts";
                        ToolTip = 'View or organize the general ledger accounts that store your financial data. All values from business transactions or internal adjustments end up in designated G/L accounts. Business Central includes a standard chart of accounts that is ready to support businesses in your country, but you can change the default accounts and add new ones.';
                    }

                    action("G/L Navigator")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'G/L Navigator';
                        Image = Journal;
                        RunObject = Page Navigate;
                    }
                    action("Account Categories")
                    {
                        ApplicationArea = Basic, Suite;

                        Image = Journal;
                        RunObject = Page "G/L Account Categories";
                    }
                }
            }
            group("Property Management")
            {
                group("Housing Projects")
                {

                    group("Properties")
                    {

                        action("Apartment Blocks")
                        {

                            Caption = 'Apartment Blocks';

                            RunObject = Page "Block List";
                        }

                        action("Units")
                        {
                            Caption = 'Units';
                            RunObject = Page "Unit List";
                            Visible = true;
                        }

                    }


                    group("Sales")
                    {
                        action("Active Sales")
                        {
                            RunObject = Page "Property Purchase List";
                            RunPageView = where(Posted = CONST(FALSE));
                        }

                        action("Posted Sales")
                        {
                            RunObject = Page "Property Purchase List";
                            RunPageView = where(Posted = CONST(TRUE));
                        }



                        // action("Rent To Own")
                        // {

                        // }
                        // action("Outright Buy")
                        // {

                        // }

                        // action("Cash Depositers")
                        // {

                        // }
                    }

                }


                group("Land Projects")
                {

                }

                group("Other Projects")
                {

                }

                group("Sales and Commissions")

                {

                }

                group("Defaulter Management")
                {

                    action("Defaulter List")
                    {
                        RunObject = Report "Defaulter List";
                    }

                    action("Trigger Defaulter Calculation")
                    {
                        RunObject = codeunit "Defaulter Functions";
                    }
                }


            }

            group("Fixed Deposits")
            {

            }
        }


    }
}