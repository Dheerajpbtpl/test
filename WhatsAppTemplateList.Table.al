#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Table 50015 "WhatsApp Template List"
{
    DrillDownPageID = "WhatsApp Templete List";
    LookupPageID = "WhatsApp Templete List";

    fields
    {
        field(1; "Template Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(10; "Message Text"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(11; "Attachement Path"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(12; "Message Text 2"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(13; "Attachment Text File Path"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(14; "Pdf File Name"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Template Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

