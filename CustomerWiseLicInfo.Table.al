table 50009 "Customer Wise Lic Info"
{
    Caption = 'Customer Wise Lic Info';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Customer No."; Code[20])
        {
            Caption = 'Customer No.';

        }
        field(2; "Licence Type"; code[30])
        {
            Caption = 'Licence Type';
            TableRelation = "Licence Types".Code;
            trigger OnValidate()
            var
                CustRec: Record Customer;
            begin
                CustRec.Reset();
                CustRec.SetRange("No.", "Customer No.");
                if CustRec.FindFirst() then
                    "Customer Name" := CustRec.Name;
            end;
        }
        field(3; "No. of Licence"; Integer)
        {
            Caption = 'No. of Licence';
        }
        field(4; "Renewal Rate"; Decimal)
        {
            Caption = 'Renewal Rate';
            trigger OnValidate()
            var
                myInt: Integer;
            begin
                Rec."Renewal Amount" := Rec."No. of Licence" * Rec."Renewal Rate";
            end;
        }
        field(5; "Renewal Amount"; Decimal)
        {
            Caption = 'Renewal Amount';
            Editable = false;
        }
        field(6; "Renewal Date"; Date)
        {
            Caption = 'Renewal Date';
        }
        field(7; "Customer Name"; Text[100])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
    }
    keys
    {
        key(PK; "Customer No.", "Licence Type")
        {
            Clustered = true;
        }
    }
}
