table 50018 "Licence Types"
{
    Caption = 'Licence Types';
    DataClassification = ToBeClassified;
    LookupPageId = "Licence Types Card";
    DrillDownPageId = "Licence Types Card";

    fields
    {
        field(1; "Code"; Code[30])
        {
            Caption = 'Code';
            DataClassification = CustomerContent;
        }
        field(2; Description; Text[100])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;
        }
    }
    keys
    {
        key(PK; "Code")
        {
            Clustered = true;
        }
    }
}
