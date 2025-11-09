Table 50006 "Service Header Bulls"
{

    fields
    {
        field(1; "No."; Code[10])
        {

            trigger OnValidate()
            begin
                if "No." <> xRec."No." then begin
                    SalesSetup.Get;
                    //  NoSeriesMgt.TestManual(SalesSetup."Service Order No.");
                    "No. Series" := '';
                end;
            end;
        }
        field(2; "Customer No."; Code[10])
        {
            TableRelation = Customer;

            trigger OnValidate()
            begin
                TestField(Status, Status::New);
                if Cust.Get("Customer No.") then begin
                    Name := Cust.Name;
                    //"Bill-to Name" := Cust.Name;
                    "Name 2" := Cust."Name 2";
                    Address := Cust.Address;
                    "Address 2" := Cust."Address 2";
                    City := Cust.City;
                    "Post Code" := Cust."Post Code";
                    County := Cust.County;
                    "Phone No." := Cust."Phone No.";
                    "Contact Person" := Cust.Contact;
                    "Service Order Date" := Today;
                    "Email ID" := Cust."E-Mail";
                    "Fax No." := Cust."Fax No.";



                end
            end;
        }
        field(3; Name; Text[50])
        {
            Editable = false;
        }
        field(4; "Name 2"; Text[50])
        {
            Editable = false;
        }
        field(5; Address; Text[50])
        {
            Editable = false;
        }
        field(6; "Address 2"; Text[50])
        {
            Editable = false;
        }
        field(7; "Phone No."; Code[15])
        {
        }
        field(8; "Contact Person"; Text[30])
        {
        }
        field(9; "Service Order Date"; Date)
        {
        }
        field(10; "Email ID"; Text[80])
        {
        }
        field(11; Status; Option)
        {
            OptionCaption = 'New,Open,Assigned,Closed';
            OptionMembers = New,Open,Assigned,Closed;
        }
        field(12; City; Text[30])
        {
        }
        field(13; "Post Code"; Code[20])
        {
        }
        field(14; County; Text[30])
        {
        }
        field(15; "No. Series"; Code[10])
        {
        }
        field(16; "Fax No."; Text[30])
        {
        }
        field(17; "Order Time"; Time)
        {
        }
        field(18; "Order Assign Date"; Date)
        {
        }
        field(19; "Order Finished Date"; Date)
        {
        }
        field(21; Resource; Code[10])
        {
            TableRelation = Contact;
        }
        field(22; Comment; Text[50])
        {
        }
        field(23; "Resource Comment"; Text[100])
        {
        }
        field(24; "Customer Comment"; Text[100])
        {
        }
        field(25; "Service Type"; Option)
        {
            OptionCaption = 'AMC,Paid,Under Implemenation,Others';
            OptionMembers = AMC,Paid,"Under Implemenation",Others;
        }
    }

    keys
    {
        key(Key1; "No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        if Status <> Status::New then
            Error('You can not delete the order ');
    end;

    trigger OnInsert()
    begin
        if "No." = '' then begin
            SalesSetup.Get;
            //  SalesSetup.TESTFIELD("Service Order No.");
            //  NoSeriesMgt.InitSeries(SalesSetup."Service Order No.",xRec."No. Series",0D,"No.","No. Series");
        end;
    end;

    var
        SalesSetup: Record "Sales & Receivables Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        Cust: Record Customer;
}

