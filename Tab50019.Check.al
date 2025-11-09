table 50019 Check
{
    Caption = 'Check';
    DataClassification = ToBeClassified;
    DrillDownPageId = Check;
    LookupPageId = Check;

    fields
    {
        field(1; "Code"; Code[100])
        {
            Caption = 'Code';
        }

        field(3; Name; Text[100])
        {
            Caption = 'Name';
        }
    }
    keys
    {
        key(PK; "code")
        {
            Clustered = true;
        }
    }
}
