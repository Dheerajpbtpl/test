Table 50010 "Licence Details"
{

    fields
    {
        field(1; "No."; Code[50])
        {
        }
        field(2; "Customer No."; Code[20])
        {
            TableRelation = Customer;

            trigger OnValidate()
            begin
                if Cust.Get("Customer No.") then begin
                    "Customer Name" := Cust.Name;
                    "Customer Address" := Cust.Address;
                    "Customer Address 2" := Cust."Address 2";
                    "Customer State" := Cust."State Code";
                    "Customer City" := Cust.City;
                    "Customer Country" := Cust."Country/Region Code";
                    "Customer Email" := Cust."E-Mail";
                    "Customer Phone No." := Cust."Phone No.";
                    "Contact Person" := Cust.Contact;
                    "Customer Company Name" := '';
                    "PAN No." := Cust."P.A.N. No.";
                    "TIN No." := 'Cust."T.I.N. No."';
                    "Service Tax No." := Cust."Service Tax No.";
                end;
            end;
        }
        field(3; "Customer Name"; Text[100])
        {
        }
        field(4; "Customer Address"; Text[70])
        {
        }
        field(5; "Customer State"; Code[20])
        {
            TableRelation = State;
        }
        field(6; "Customer City"; Code[30])
        {
            TableRelation = if ("Customer Country" = const('')) "Post Code".City
            else
            if ("Customer Country" = filter(<> '')) "Post Code".City where("Country/Region Code" = field("Customer Country"));
        }
        field(7; "Customer Country"; Code[10])
        {
            TableRelation = "Country/Region";
        }
        field(8; "Customer Email"; Text[70])
        {
        }
        field(9; "Customer Phone No."; Code[30])
        {
        }
        field(10; "Contact Person"; Text[50])
        {
        }
        field(11; "Customer Company Name"; Text[70])
        {
        }
        field(12; "Customer Address 2"; Text[70])
        {
        }
        field(20; "Activate Date"; Date)
        {
        }
        field(21; "Serial Number"; Text[100])
        {
        }
        field(30; "PAN No."; Code[30])
        {
        }
        field(31; "TIN No."; Code[30])
        {
        }
        field(32; "Service Tax No."; Code[30])
        {
        }
        field(40; "Type of Industry"; Code[50])
        {
        }
        field(41; Segment; Code[50])
        {
        }
        field(42; "Partner Name"; Text[100])
        {
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

    var
        Cust: Record Customer;
}

