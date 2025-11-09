Table 50068 "Leave Type-PBTPL"
{

    fields
    {
        field(1; ID; Code[20])
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                /*IF ID<>xRec.ID THEN BEGIN
                 SalesSetup.GET;
                 NoSeriesMgt.TestManual(SalesSetup."Leave Type");
                 "No. Series":='';
                 NoSeriesMgt.SetSeries(ID);
                 END;*/

            end;
        }
        field(2; Name; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "No Of Leave"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Created Date"; DateTime)
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Created By"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Modify Date"; DateTime)
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Modified By"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(8; "No. Series"; Code[30])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; ID, Name)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        /*IF ID='' THEN BEGIN
          SalesSetup.GET;
          SalesSetup.TESTFIELD("Leave Type");
          NoSeriesMgt.InitSeries(SalesSetup."Leave Type",xRec.ID,0D,ID,"No. Series");
          END;*/


        "Created By" := UserId;
        "Created Date" := CurrentDatetime;

    end;

    trigger OnModify()
    begin
        "Modified By" := UserId;
        "Modify Date" := CurrentDatetime;
    end;

    var
        SalesSetup: Record "Sales & Receivables Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
}

