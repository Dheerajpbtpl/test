Table 50052 "Shift Timing-PBTPL"
{

    fields
    {
        field(1; "Shift Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Shift Time In"; Time)
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Shift Time Out"; Time)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin

                if "Shift Time In" > "Shift Time Out" then begin
                    //    temp:=000101T;

                    Evaluate(temp, '24');
                    //      MESSAGE(FORMAT(temp));
                    "Valid Hours" := "Shift Time In" - "Shift Time Out";

                    "Valid Hours" := temp - "Valid Hours";
                end
                else begin

                    "Valid Hours" := "Shift Time Out" - "Shift Time In";

                end;
            end;
        }
        field(5; "Valid Hours"; Duration)
        {
            DataClassification = ToBeClassified;
        }
        field(6; ID; Code[30])
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                /*IF ID<>xRec.ID THEN BEGIN
                 SalesSetup.GET;
                 //NoSeriesMgt.TestManual(SalesSetup."Shift Timing");
                 "No. Series":='';
                 NoSeriesMgt.SetSeries(ID);
                 END;*/

            end;
        }
        field(7; "Created Date"; DateTime)
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Created By"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(9; "Modify Date"; DateTime)
        {
            DataClassification = ToBeClassified;
        }
        field(10; "Modified By"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(11; "No. Series"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Shift Code", ID)
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
         //SalesSetup.TESTFIELD("Shift Timing");
         //NoSeriesMgt.InitSeries(SalesSetup."Shift Timing",xRec."No. Series",0D,ID,"No. Series");
         END;
         */

        "Created By" := UserId;
        "Created Date" := CurrentDatetime;

    end;

    trigger OnModify()
    begin
        "Modified By" := UserId;
        "Modify Date" := CurrentDatetime;
    end;

    var
        DayHour: Time;
        temp: Duration;
        SalesSetup: Record "Sales & Receivables Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
}

