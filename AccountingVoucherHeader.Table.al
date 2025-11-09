Table 50061 "Accounting Voucher Header"
{

    fields
    {
        field(1; "Document Type"; Option)
        {
            OptionMembers = " ",Payment,Receipt,Journal,Contra;
        }
        field(2; "Transaction No"; Code[30])
        {
        }
        field(10; "Document Sub Type"; Option)
        {
            OptionCaption = ' ,Payment,Invoice,Credit Memo,Finance Charge Memo,Reminder,Refund';
            OptionMembers = " ",Payment,Invoice,"Credit Memo","Finance Charge Memo",Reminder,Refund;

            trigger OnValidate()
            begin
                if "Created By" = '' then begin
                    "Posting Date" := Today;
                    "Created By" := UserId;
                    "Created Date" := Today;
                    "Created Time" := Time;
                end;
            end;
        }
        field(11; "Journal Template Name"; Code[10])
        {
            TableRelation = "Gen. Journal Template";
        }
        field(12; "Journal Batch Name"; Code[10])
        {

            trigger OnValidate()
            begin
                UpdateLocation;
            end;
        }
        field(13; Location; Code[10])
        {
            TableRelation = Location where("Use As In-Transit" = filter(false));

            trigger OnValidate()
            begin
                TestField(Status, Status::Open);
            end;
        }
        field(14; "Posting Date"; Date)
        {

            trigger OnValidate()
            begin
                if "Created By" = '' then begin
                    "Created By" := UserId;
                    "Created Date" := Today;
                    "Created Time" := Time;
                    Status := Status::Open;
                end;
                TestField(Status, Status::Open);
            end;
        }
        field(15; "Created By"; Code[20])
        {
        }
        field(16; "Created Date"; Date)
        {
        }
        field(17; "Created Time"; Time)
        {
        }
        field(18; Posted; Boolean)
        {
        }
        field(19; "Sender ID"; Code[50])
        {
            TableRelation = "User Setup"."User ID";
        }
        field(20; "Approver ID"; Code[50])
        {
            TableRelation = "User Setup"."User ID";
        }
        field(21; "Second Approver ID"; Code[50])
        {
            TableRelation = "User Setup"."User ID";
        }
        field(22; Status; Option)
        {
            OptionMembers = Open,Pending,Approved;
        }
        field(23; "Approved By"; Code[50])
        {
            TableRelation = "User Setup"."User ID";
        }
        field(24; "Sent For Approval"; Boolean)
        {
        }
        field(25; Approved; Boolean)
        {
        }
        field(26; "Shortcut Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,2,1';
            Caption = 'Shortcut Dimension 1 Code';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));
        }
        field(27; "Shortcut Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,2,2';
            Caption = 'Shortcut Dimension 2 Code';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));
        }
    }

    keys
    {
        key(Key1; "Document Type", "Transaction No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        AcctVchLine.SetRange(AcctVchLine."Transaction No", "Transaction No");
        AcctVchLine.DeleteAll;
    end;

    var
        AcctVchLine: Record "Accounting Voucher Line";
        GenJnlBatch: Record "Gen. Journal Batch";


    procedure AssistEdit(InputDoctType: Option " ",Payment,Receipt,Journal,Contra)
    var
        SalesSetup: Record "Sales & Receivables Setup";
        NoSeriesMgmt: Codeunit NoSeriesManagement;
    begin
        if "Transaction No" = '' then begin
            SalesSetup.Get;
            if InputDoctType = Inputdocttype::Payment then
                "Transaction No" := NoSeriesMgmt.GetNextNo(SalesSetup."Pymt Order Nos.", Today, true)
            else
                if InputDoctType = Inputdocttype::Receipt then
                    "Transaction No" := NoSeriesMgmt.GetNextNo(SalesSetup."Rcpt Order Nos.", Today, true)
                else
                    if InputDoctType = Inputdocttype::Contra then
                        "Transaction No" := NoSeriesMgmt.GetNextNo(SalesSetup."Contra Order Nos.", Today, true)
                    else
                        "Transaction No" := NoSeriesMgmt.GetNextNo(SalesSetup."Jrnl Order Nos.", Today, true);
        end;
    end;


    procedure UpdateLocation()
    begin
        TestField("Journal Template Name");
        TestField("Journal Batch Name");

        GenJnlBatch.Reset;
        GenJnlBatch.SetRange(GenJnlBatch."Journal Template Name", "Journal Template Name");
        GenJnlBatch.SetRange(GenJnlBatch.Name, "Journal Batch Name");
        if GenJnlBatch.FindFirst then begin
            Location := GenJnlBatch."Location Code";
        end;
    end;
}

