Codeunit 50027 "Web Portal Integration"
{


    procedure CreateCustomer(

       CustomerName: Text[100];
       MobileNo: Code[20];
       Email: Text[50];
       IdNo: Code[20];
       PassportNo: Code[20];
       IdDocFront: Text;
       IdDocBack: Text;
       KraPin: Code[20];
       KraPinDoc: Text;
       AtmNo: Code[50];
       AtmCardFront: Text

       ): Text

    var

        Response: JsonObject;
        Customer: Record Customer;
        NoSeriesMgmt: Codeunit "No. Series";
        SalesSetup: Record "Sales & Receivables Setup";
        Base64Convert: Codeunit "Base64 Convert";
        TempBlob: Codeunit "Temp Blob";
        OutStr: OutStream;
        InStr: InStream;

    begin


        //  Response.Add('success', false);
        //Response.Add('message', StrSubstNo('An error occurred'));


        SalesSetup.Get();


        Customer.Init();

        Customer."No." := NoSeriesMgmt.GetNextNo(SalesSetup."Customer Nos.", WorkDate(), true);

        Customer.Name := CustomerName;

        Customer."Mobile Phone No." := MobileNo;

        Customer."E-Mail" := Email;

        Customer."Id No." := IdNo;

        Customer."Passport No." := PassportNo;

        Customer."ATM No." := AtmNo;

        Customer."KRA Pin" := KraPin;



        if IdDocFront <> '' then begin
            Clear(TempBlob);
            TempBlob.CreateOutStream(OutStr);
            Base64Convert.FromBase64(IdDocFront, OutStr);

            // Write decoded image into the Blob field
            Clear(Customer.IdentityDocFront);
            Customer.IdentityDocFront.CreateOutStream(OutStr);
            TempBlob.CreateInStream(InStr);
            CopyStream(OutStr, InStr);
        end;

        if IdDocBack <> '' then begin
            Clear(TempBlob);
            TempBlob.CreateOutStream(OutStr);
            Base64Convert.FromBase64(IdDocBack, OutStr);

            // Write decoded image into the Blob field
            Clear(Customer.IdentityDocBack);
            Customer.IdentityDocBack.CreateOutStream(OutStr);
            TempBlob.CreateInStream(InStr);
            CopyStream(OutStr, InStr);
        end;


        if KraPindOC <> '' then begin
            Clear(TempBlob);
            TempBlob.CreateOutStream(OutStr);
            Base64Convert.FromBase64(KraPinDoc, OutStr);

            // Write decoded image into the Blob field
            Clear(Customer.KRAPinDoc);
            Customer.KRAPinDoc.CreateOutStream(OutStr);
            TempBlob.CreateInStream(InStr);
            CopyStream(OutStr, InStr);
        end;


        if AtmCardFront <> '' then begin
            Clear(TempBlob);
            TempBlob.CreateOutStream(OutStr);
            Base64Convert.FromBase64(AtmCardFront, OutStr);

            // Write decoded image into the Blob field
            Clear(Customer.AtmDoc);
            Customer.ATMDoc.CreateOutStream(OutStr);
            TempBlob.CreateInStream(InStr);
            CopyStream(OutStr, InStr);
        end;


        IF Customer.Insert(TRUE) THEN BEGIN

            Response.Add('success', true);
            Response.Add('customerNo', Customer."No.");
            Response.Add('message', StrSubstNo('Customer %1 created successfuly', Customer."No."));
            exit(Format(Response));


        END else begin

            Response.Add('success', false);
            Response.Add('message', StrSubstNo('Insert Record failed'));
            exit(Format(Response));

        end;

        exit(Format(Response));



    end;



    procedure GetProjects(): tEXT

    var

        Projects: Record Block;
        Response: JsonObject;
        FinalResponse: JsonObject;

        Array: JsonArray;

    begin


        // FinalResponse.Add('success', false);
        //FinalResponse.Add('message', 'an error occurred');

        Projects.Reset();

        if Projects.FindSet() then begin

            repeat
                Clear(Response);

                Response.Add('Project No.', Projects.No);
                Response.add('Description', Projects.Description);
                Response.add('Location', Projects.Location);
                Response.add('Townhouse Cost', Projects."Townhouse Cost");
                Response.add('2-Bedroom Cosr', Projects."Two - Bedroom Cost");
                Response.add('3-Bedroom Cost', Projects."Three - Bedroom Cost");
                Response.add('Townhouses', Projects.Townhouses);
                Response.add('2-Bedrooms', Projects."Two - Bedroom Units");
                Response.add('3-Bedrooms', Projects."Three - Bedroom Units");

                Array.Add(Response);

            until Projects.Next() = 0;

        end;


        FinalResponse.Add('success', true);
        FinalResponse.Add('projects', Array);

        exit(Format(FinalResponse))

    end;



}