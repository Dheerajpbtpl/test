Table 50056 "Employee Master"
{
    // Permissions = TableData 50024 = rimd;

    fields
    {
        field(1; "Code"; Code[10])
        {

            trigger OnValidate()
            begin
                if Code <> xRec.Code then begin
                    PayrollSetupPBTPL.Get;
                    NoSeriesMgmt.TestManual(PayrollSetupPBTPL."Primary key");
                    Code := '';
                end;
            end;
        }
        field(3; "Date of Joining"; Date)
        {
            NotBlank = true;
        }
        field(4; "Date Of Birth"; Date)
        {
            NotBlank = false;
        }
        field(5; "Date Of Anniversery"; Date)
        {
        }
        field(6; "Parent Name"; Text[50])
        {
        }
        field(7; "Blood Group"; Option)
        {
            OptionCaption = ',,A1B Negative,A1B Positive,A1 Negative,A1 Positive,A2B Negative,A2B Positive,A2 Negative,A2 Positive,AB Negative,AB Positive,A Negative,A Positive,B Negative,B Positive,O Negative,O Positive';
            OptionMembers = " ",,"A1B Negative","A1B Positive","A1 Negative","A1 Positive","A2B Negative","A2B Positive","A2 Negative","A2 Positive","AB Negative","AB Positive","A Negative","A Positive","B Negative","B Positive","O Negative","O Positive";
        }
        field(8; Designation; Text[50])
        {


            //TableRelation = employee.Degination;

        }
        field(9; "Emloyee Group"; Code[10])
        {
            TableRelation = "Employee Group";
        }
        field(10; Qualification; Text[30])
        {
        }
        field(11; Address; Text[250])
        {
        }
        field(12; "Address 2"; Text[250])
        {
        }
        field(13; "Post Code"; Code[10])
        {
            TableRelation = "Post Code".Code;

            trigger OnValidate()
            var
                PostCode_: Record "Post Code";
            begin
                PostCode_.Reset;
                PostCode_.SetRange(Code, "Post Code");
                Clear(PostCodes);
                PostCodes.SetRecord(PostCode_);
                PostCodes.SetTableview(PostCode_);
                PostCodes.LookupMode(true);
                if PostCodes.RunModal = Action::LookupOK then begin
                    PostCodes.GetRecord(PostCode_);
                    "City Name" := PostCode_.City;
                    "City Code" := PostCode_.City;
                    //AVALIDATE("State Code",PostCode_.State);
                    Validate("Country Code", PostCode_."Country/Region Code");
                end;
            end;






        }
        field(14; "City Code"; Code[15])
        {

            trigger OnLookup()
            var
                PostCode_: Record "Post Code";
            begin
            end;
        }
        field(15; "City Name"; Text[30])
        {
        }
        field(16; "State Code"; Code[10])
        {
            TableRelation = State.Code;

            trigger OnValidate()
            begin
                State_Rec.Reset;
                if State_Rec.Get("State Code") then
                    Validate("State Name", State_Rec.Description)
                else
                    "State Name" := '';
            end;
        }
        field(17; "State Name"; Text[30])
        {
        }
        field(18; "Country Code"; Code[10])
        {
            TableRelation = "Country/Region".Code;

            trigger OnValidate()
            begin
                CountryRegion_Rec.Reset;
                if CountryRegion_Rec.Get("Country Code") then
                    Validate("Country Name", CountryRegion_Rec.Name)
                else
                    "Country Name" := '';
            end;
        }
        field(19; "Country Name"; Text[30])
        {
        }
        field(20; "Phone No"; Text[30])
        {
        }
        field(21; "Mobile No"; Text[30])
        {

            trigger OnValidate()
            begin
                if "Mobile No" <> '' then
                    if (StrLen("Mobile No") <> 10) and ("Country Code" = 'IN') then
                        Error('Mobile No. is wrong');
            end;
        }
        field(22; "Email Id 2"; Text[40])
        {

            trigger OnValidate()
            begin
                if "Email Id 2" <> '' then begin
                    if StrPos("Email Id 2", '@') > 0 then begin
                    end else
                        Error('Emai Id is wrong');
                end;
                if StrPos("Email Id 2", ' ') > 0 then
                    Error('Please remove space');
                if "Email Id 2" <> '' then begin
                    if StrPos("Email Id 2", '.') > 0 then begin
                    end else
                        Error('Emai Id is wrong');
                end;
            end;
        }
        field(23; "Email Id 1"; Text[40])
        {

            trigger OnValidate()
            begin
                if "Email Id 1" <> '' then begin
                    if StrPos("Email Id 1", '@') > 0 then begin
                    end else
                        Error('Emai Id is wrong');
                end;
                if StrPos("Email Id 1", ' ') > 0 then
                    Error('Please remove space');
                if "Email Id 1" <> '' then begin
                    if StrPos("Email Id 1", '.') > 0 then begin
                    end else
                        Error('Emai Id is wrong');
                end;
            end;
        }
        field(24; "PAN No"; Text[30])
        {
        }
        field(50; Resigned; Boolean)
        {

            trigger OnValidate()
            begin
                if Resigned = false then begin
                    "Resign Date" := 0D;
                    "Resign Reason" := ''
                end;
            end;
        }
        field(51; "Resign Date"; Date)
        {

            trigger OnValidate()
            begin
                TestField(Resigned, true);
            end;
        }
        field(60; "Shortcut Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,2,1';
            Caption = 'Shortcut Dimension 1 Code';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));
        }
        field(61; "Shortcut Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,2,2';
            Caption = 'Shortcut Dimension 2 Code';
            Editable = false;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(4));
        }
        field(71; "Working Hours Time"; Time)
        {
        }
        field(80; "First Name"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(81; "Last Name"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(82; "Insurance No."; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(100; Department; Text[50])
        {
            TableRelation = "Emp Department-pb";

            trigger OnValidate()
            begin
                /*ProductSubGroupLink.RESET;
                ProductSubGroupLink.SETRANGE("Product Exp Sub Group",Department);
                IF ProductSubGroupLink.FINDFIRST THEN
                  "Shortcut Dimension 1 Code":= ProductSubGroupLink."Product Group Code"
                ELSE
                  "Shortcut Dimension 1 Code":='';
                  */

            end;
        }
        field(101; "Token No."; Text[30])
        {
        }
        field(102; Gender; Option)
        {
            OptionCaption = 'Male,Female, ';
            OptionMembers = Male,Female," ";
        }
        field(103; "Lunch Amount"; Decimal)
        {
        }
        field(104; "PF No."; Code[50])
        {
        }
        field(105; "Welfare Amount"; Decimal)
        {
        }
        field(107; "Perk Month"; Code[20])
        {
        }
        field(108; "OT Applicable"; Boolean)
        {
        }
        field(110; "PF Applicable"; Boolean)
        {
        }
        field(111; "FPS Applicable"; Boolean)
        {
        }
        field(112; "Bank Name"; Text[50])
        {
        }
        field(113; "Bank Account No."; Code[30])
        {
        }
        field(114; "IFSC Code"; Code[20])
        {
        }
        field(115; "UAN No"; Code[30])
        {
        }
        field(120; Basic; Decimal)
        {

            trigger OnValidate()
            begin
                /*IF "HRA P/A" = "HRA P/A"::"0" THEN
                  "Gross Rate" := Basic + ((Basic * HRA)/100);
                IF "HRA P/A" = "HRA P/A"::"1" THEN
                  "Gross Rate" := Basic + HRA;*/

            end;
        }
        field(121; HRA; Decimal)
        {

            trigger OnValidate()
            begin
                /*IF "HRA P/A" = "HRA P/A"::"0" THEN
                  "Gross Rate" := Basic + ((Basic * HRA)/100);
                IF "HRA P/A" = "HRA P/A"::"1" THEN
                  "Gross Rate" := Basic + HRA;*/

            end;
        }
        field(141; "Created By"; Text[30])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(142; "Interview By"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(200; "No. Series"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50024; "Mother Name"; Text[30])
        {
        }
        field(50025; Group; Option)
        {
            DataClassification = CustomerContent;
            OptionCaption = ' ,Unskilled,Semi-skilled,Skilled,Non Matriculates,Matriculates Graduate,Graduate and Above';
            OptionMembers = " ",Unskilled,"Semi-skilled",Skilled,"Non Matriculates","Matriculates Graduate","Graduate and Above";
        }
        field(50031; "Leaving Date"; Date)
        {
        }
        field(50033; Rest; Integer)
        {
        }
        field(50044; Gross; Decimal)
        {
            FieldClass = Normal;
        }
        field(50049; "Manual Att."; Boolean)
        {
        }
        field(50051; "HRD Person"; Text[30])
        {
        }
        field(50055; "Spouse Mobile No."; Text[10])
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                if "Spouse Mobile No." <> '' then
                    if StrLen("Spouse Mobile No.") <> 10 then
                        Error('Mobile No. is wrong');
            end;
        }
        field(50056; "Spouse Name"; Text[100])
        {
        }
        field(50057; "Marital Status"; Option)
        {
            OptionMembers = " ",Single,Married;
        }
        field(50058; "ID Mark"; Text[50])
        {
        }
        field(50062; "Pay Type"; Text[30])
        {
        }
        field(50064; "PF Join Date"; Date)
        {
        }
        field(50066; "Aadhar No."; Text[12])
        {
        }
        field(50071; "Resi Phone no."; Text[100])
        {
            Caption = 'Resi Phone no.';
        }
        field(50077; "PF Amount"; Decimal)
        {
        }
        field(50078; Arrear; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50079; Increment; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50100; Picture; Blob)
        {
            Caption = 'Picture';
            SubType = Bitmap;
        }
        field(50103; "Special Leaves"; Option)
        {
            OptionCaption = ' ,1,2,3,4,5,6';
            OptionMembers = " ","1","2","3","4","5","6";
        }
        field(50104; "Fixed Rest"; Boolean)
        {
        }
        field(50105; "Extra Days in Month"; Integer)
        {
        }
        field(50108; "Compan's Mobile No."; Text[10])
        {
        }
        field(50112; "TA/DA Group"; Option)
        {
            OptionCaption = ' ,Bread,Bakery,Other';
            OptionMembers = " ",Bread,Bakery,Other;
        }
        field(50113; "UAN PASS"; Text[30])
        {
        }
        field(50114; "HRA Percentage"; Decimal)
        {
        }
        field(50117; "Member ID"; Text[30])
        {
        }
        field(50118; "Nominee Name"; Text[50])
        {
        }
        field(50119; "Local Address"; Text[200])
        {
        }
        field(50120; TRPT; Text[30])
        {
        }
        field(50121; "Weekly Off Day"; Text[30])
        {
        }
        field(50122; "P.F Limits EE"; Integer)
        {
        }
        field(50123; "P.F Percentage EE"; Decimal)
        {
        }
        field(50124; Bonus; Boolean)
        {
        }
        field(50125; "L.W.F"; Boolean)
        {
        }
        field(50126; FP; Boolean)
        {
        }
        field(50127; "Lunch/Mess  DED."; Boolean)
        {
        }
        field(50128; "P.F F.F. Date"; Date)
        {
        }
        field(50129; "D.O.L"; Date)
        {
        }
        field(50130; "D.O.E"; Date)
        {
        }
        field(50131; Remark; Text[100])
        {
        }
        field(50132; "Remark 2"; Text[100])
        {
        }
        field(50133; "P.F Limits ER"; Integer)
        {
        }
        field(50134; "P.F Percentage ER"; Decimal)
        {
        }
        field(50135; "L.W.W"; Boolean)
        {
        }
        field(50136; PSDT; Boolean)
        {
        }
        field(50137; "CONT. Fund"; Boolean)
        {
        }
        field(50138; "CL."; Boolean)
        {
        }
        field(50139; "Permanant Address"; Text[200])
        {
        }
        field(50148; "Company Name"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(50149; "Company Owner Name"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(50150; "Company Mobile No."; Text[10])
        {
            DataClassification = ToBeClassified;
        }
        field(50152; "Location Code"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = Location;
        }
        field(50154; "Advance Imprest G/L No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account"."No.";
        }
        field(50155; Block; Option)
        {
            DataClassification = ToBeClassified;
            Editable = false;
            OptionCaption = 'Not Approved,Pending,Approved,Resigned';
            OptionMembers = "Not Approved",Pending,Approved,Resigned;
        }
        field(50156; "Old PF No."; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(50157; "Old UAN No."; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(50158; "Old UAN Password"; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(50159; "Police Verify Docs"; Boolean)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            var
                UserSetup: Record "User Setup";
            begin
            end;
        }
        field(50160; "Advance Imprest Balance"; Decimal)
        {
            CalcFormula = sum("G/L Entry".Amount where("G/L Account No." = field("Advance Imprest G/L No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50161; CTC; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50172; Documents; Text[250])
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            var
                UserSetup: Record "User Setup";
            begin
                Clear(UserSetup);
                if (xRec.Documents <> '') and (Block = Block::Approved) then begin
                    UserSetup.Get(UserId);
                    /*IF (UserSetup."Type of User" = UserSetup."Type of User"::"3") OR (UserSetup."Type of User" = UserSetup."Type of User"::"5") THEN BEGIN

                    END ELSE
                      ERROR('You do not have permission');
                    *///A
                end;

            end;
        }
        field(50173; Experience; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50174; "Employee User ID"; Code[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = "User Setup"."User ID";

            trigger OnValidate()
            begin
                "Employee User ID" := Rec."Employee User ID";
            end;
        }
        field(50175; "Permannent Post Code"; Code[10])
        {
            TableRelation = "Post Code".Code;

            trigger OnValidate()
            var
                PostCode_: Record "Post Code";
            begin
                PostCode_.Reset;
                PostCode_.SetRange(Code, "Permannent Post Code");
                Clear(PostCodes);
                PostCodes.SetRecord(PostCode_);
                PostCodes.SetTableview(PostCode_);
                PostCodes.LookupMode(true);
                if PostCodes.RunModal = Action::LookupOK then begin
                    PostCodes.GetRecord(PostCode_);
                    "Permannent City Name" := PostCode_.City;
                    "Permannent City Code" := PostCode_.City;
                    //AVALIDATE("Permannent State Code",PostCode_.State);
                end;
                if "Permannent Post Code" = '' then begin
                    "Permannent City Name" := '';
                    "Permannent City Code" := '';
                    "Permannent State Code" := '';
                    "Permannent State Name" := '';
                end;
            end;
        }
        field(50176; "Permannent City Code"; Code[15])
        {

            trigger OnLookup()
            var
                PostCode_: Record "Post Code";
            begin
            end;
        }
        field(50177; "Permannent City Name"; Text[30])
        {
            Editable = false;
        }
        field(50178; "Permannent State Code"; Code[10])
        {
            TableRelation = State.Code;

            trigger OnValidate()
            begin
                State_Rec.Reset;
                if State_Rec.Get("Permannent State Code") then
                    Validate("Permannent State Name", State_Rec.Description)
                else
                    "Permannent State Name" := '';
            end;
        }
        field(50179; "Permannent State Name"; Text[30])
        {
            Editable = false;
        }
        field(50180; "Resign Reason"; Text[250])
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                TestField(Resigned, true);
            end;
        }
        field(50181; Driver; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50182; "Emp ID As per Attendance"; Code[10])
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                "Employee User ID" := Rec."Employee User ID";
            end;
        }
        field(50183; "ESI Applicable"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50184; "Employee Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Permanent,Casual,Worker';
            OptionMembers = Permanent,Casual,Worker;
        }
        field(50186; "Overtime Given"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50187; "Lunch Hours Add"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50188; "Week Off-Day"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Sunday,Monday,Tuesday,Wednesday,Thursday,Friday,Saturday';
            OptionMembers = Sunday,Monday,Tuesday,Wednesday,Thursday,Friday,Saturday;

            trigger OnValidate()
            begin
                if "Week Off-Day" = "week off-day"::Monday then;
            end;
        }
        field(50189; "ESI No."; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(50190; Weekday; Integer)
        {
            DataClassification = ToBeClassified;
        }
#pragma warning disable AL0685
        field(50191; "Shift CODE"; Code[10])
#pragma warning restore AL0685
        {
            CalcFormula = lookup("Shift Timing-PBTPL"."Shift Code" where(ID = field(Code)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50192; Advance; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(50193; Active; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Active,Unactive;
        }
        field(50194; "Duty Hrs"; Text[5])
        {
            DataClassification = ToBeClassified;
        }
        field(50195; Type; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = "Mr.","Mrs.",Miss;
        }
    }

    keys
    {
        key(Key1; "Code")
        {
            Clustered = true;
        }
        key(Key2; Designation)
        {
        }
        key(Key3; "First Name")
        {
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Code", "First Name", Designation)
        {
        }
    }

    trigger OnDelete()
    begin



        /*EmpLeaveDetails.SETRANGE("Employee Code",Code);
        EmpLeaveDetails.DELETEALL;
        */
        //EmpLeavePeriod.SETRANGE("Employee Code",Code);
        //EmpLeavePeriod.DELETEALL;


        /*ESIReferenceDetails.SETRANGE("Employee No.",Code);
        ESIReferenceDetails.DELETEALL;
        */
        /*JobDescriptionDetails.SETRANGE("Employee No.",Code);
        JobDescriptionDetails.DELETEALL;
        */
        /*DailyWorkList.SETRANGE("Employee No.",Code);
        DailyWorkList.DELETEALL;
        */
        //EmployeeLeavePeriod.SETRANGE("Employee Code",Code);
        //EmployeeLeavePeriod.DELETEALL;

        /*EmployeeLeaveDetails.SETRANGE("Employee Code",Code);
        EmployeeLeaveDetails.DELETEALL;
        */
        //EmployeeOvertimeDetails.SETRANGE("Employee No.",Code);
        //EmployeeOvertimeDetails.DELETEALL;

    end;

    trigger OnInsert()
    begin
        if Code = '' then begin
            PayrollSetupPBTPL.Get;

            NoSeriesMgmt.InitSeries(PayrollSetupPBTPL."Employee No. Series", xRec."No. Series", 0D, Code, "No. Series");
        end;

        "Created By" := UserId;
    end;

    trigger OnModify()
    begin
        UserSetup.Get(UserId);
        //AIF (Block = Block::Approved) AND (UserSetup."Type of User" <> UserSetup."Type of User"::"3") THEN
        Block := Block::Pending;
    end;

    var
        GeneralLedgerSetup: Record "General Ledger Setup";
        NoSeriesMgmt: Codeunit NoSeriesManagement;
        empsetup: Record "SMS Body Template-PBTPL";
        PostCode_Rec: Record "Post Code";
        State_Rec: Record State;
        CountryRegion_Rec: Record "Country/Region";
        PostCodes: Page "Post Codes";
        UserSetup: Record "User Setup";
        PayrollSetupPBTPL: Record "Payroll Setup-PBTPL";


    procedure AssistEdit(OldCust: Record "Employee Master"): Boolean
    var
        NoSeriesMgmt: Codeunit NoSeriesManagement;
        // EmpSetup: Record "Quality Test M";
        Cust: Record "Employee Master";
    begin
        if Code = '' then begin
            PayrollSetupPBTPL.Get;
            Code := NoSeriesMgmt.GetNextNo(PayrollSetupPBTPL."Employee No. Series", WorkDate, true);
        end;
        /*
        WITH Cust DO BEGIN
          Cust := Rec;
          PayrollSetupPBTPL.GET;
        
          IF NoSeriesMgmt.SelectSeries(PayrollSetupPBTPL."Employee No. Series",OldCust."No. Series","No. Series") THEN BEGIN
            NoSeriesMgmt.SetSeries(Code);
            Rec := Cust;
            EXIT(TRUE);
          END;
        END;
        */

    end;
}

