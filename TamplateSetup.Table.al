Table 50021 "Tamplate Setup"
{

    fields
    {
        field(1; "Template Name"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Template Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,IMAGE,HTML,PDF,HTML & PDF,IMAGE & PDF,HTML & IMAGE,IMAGE & PDF & HTML';
            OptionMembers = " ",IMAGE,HTML,PDF,"HTML & PDF","IMAGE & PDF","HTML & IMAGE","IMAGE & PDF & HTML";
        }
        field(3; "Create Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Modified Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Is Active"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Image Path"; Text[150])
        {
            DataClassification = ToBeClassified;
        }
        field(7; "PDF Path"; Text[150])
        {
            DataClassification = ToBeClassified;
        }
        field(8; "HTML Path"; Text[150])
        {
            DataClassification = ToBeClassified;
        }
        field(9; "Product Url Link"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(10; "Attachment Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'PNG,JPG,GIF,PDF,HTML';
            OptionMembers = "PNG","JPG","GIF","PDF","HTML";
        }
        field(11; AttachmentFile; Blob)
        {
        }
        // field(11; "Product Url Link"; Text[1050])
        // {
        //     DataClassification = ToBeClassified;
        // }
        field(12; "Heading 1"; Text[500])
        {
            DataClassification = ToBeClassified;
        }
        field(13; "Heading 2"; Text[500])
        {
            DataClassification = ToBeClassified;
        }
        field(14; "Heading 3"; Text[500])
        {
            DataClassification = ToBeClassified;
        }
        field(15; "Information 1"; Text[2048])
        {
            DataClassification = ToBeClassified;
        }
        field(16; "Information 2"; Text[2048])
        {
            DataClassification = ToBeClassified;
        }
        field(17; "Information 3"; Text[2048])
        {
            DataClassification = ToBeClassified;
        }
        field(18; Width; Text[10])
        {
            DataClassification = ToBeClassified;
        }
        field(19; Height; Text[10])
        {
            DataClassification = ToBeClassified;
        }
        field(20; "Text Width"; Text[10])
        {
            DataClassification = ToBeClassified;
        }
        field(22; "Whats App Is Active"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(23; SendMailCount; Integer)
        {
            DataClassification = ToBeClassified;
            trigger OnValidate()
            var
                myInt: Integer;
            begin
                if Rec.SendMailCount = 0 then
                    Rec."Last Sent Date" := CurrentDateTime - 3600000;
            end;
        }
        field(24; "Last Sent Date"; DateTime)
        {
            DataClassification = ToBeClassified;
        }

    }

    keys
    {
        key(Key1; "Template Name")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

