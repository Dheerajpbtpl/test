/// <summary>
/// Report PDC in HAND (ID 50000).
/// </summary>
Report 50000 "PDC in HAND"
{
    RDLCLayout = './Layouts/PDCinHAND.rdlc';
    DefaultLayout = RDLC;

    dataset
    {
        dataitem(PDC; PDC)
        {
            DataItemTableView = sorting("PDC Cheque Date", "PDC Status", "Res Center", "Account Type", "Account No.") where("PDC Status" = filter(<> Posted), "Account Type" = const(Customer));
            column(COMPANYNAME; COMPANYNAME)
            {
            }
            column(FORMAT_TODAY_0_4_; Format(Today, 0, 4))
            {
            }
            column(UserId; UserId)
            {
            }
            column(PDC__PDC_Cheque_Date_; PDC."PDC Cheque Date")
            {
            }
            column(PDC_Name; PDC.Name)
            {
            }
            column(PDC_PDC__Account_No__; PDC."Account No.")
            {
            }
            column(PDC_PDC__PDC_Cheque_No__; PDC."PDC Cheque No.")
            {
            }
            column(PDC_PDC__PDC_Amount_; PDC."PDC Amount")
            {
            }
            column(PDC_PDC__PDC_Amount__Control1000000009; PDC."PDC Amount")
            {
            }
            column(PDC_PDC__PDC_Amount__Control1000000011; PDC."PDC Amount")
            {
            }
            column(PDC_in_HANDCaption; PDC_in_HANDCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(CHEQUE_NOCaption; CHEQUE_NOCaptionLbl)
            {
            }
            column(INVOICE_NOCaption; INVOICE_NOCaptionLbl)
            {
            }
            column(INVOICE_DATECaption; INVOICE_DATECaptionLbl)
            {
            }
            column(PENDING_AMTCaption; PENDING_AMTCaptionLbl)
            {
            }
            column(CHEQUE_AMTCaption; CHEQUE_AMTCaptionLbl)
            {
            }
            column(PDC_REFERENCECaption; PDC_REFERENCECaptionLbl)
            {
            }
            column(DUE_DATECaption; DUE_DATECaptionLbl)
            {
            }
            column(Cheque_DateCaption; Cheque_DateCaptionLbl)
            {
            }
            column(PDC_Entry_No_; PDC."Entry No.")
            {
            }
            dataitem("PDC Application Entry"; "PDC Application Entry")
            {
                DataItemLink = "PDC Entry No." = field("Entry No.");
                DataItemTableView = where("Document Type" = const(Invoice));
                column(PDC__Applies_to_ID_; PDC."Applies-to ID")
                {
                }
                column(PendingAmount; PendingAmount)
                {
                }
                column(CustLegderEntry__Due_Date_; CustLegderEntry."Due Date")
                {
                }
                column(CustLegderEntry__Document_No__; CustLegderEntry."Document No.")
                {
                }
                column(CustLegderEntry__Document_Date_; CustLegderEntry."Document Date")
                {
                }
                column(PDC_Application_Entry_PDC_Entry_No_; "PDC Application Entry"."PDC Entry No.")
                {
                }
                column(PDC_Application_Entry_Cust_Ledger_Entry_No_; "PDC Application Entry"."Cust Ledger Entry No.")
                {
                }
                trigger OnAfterGetRecord();
                begin
                    CustLegderEntry.SetRange(CustLegderEntry."Entry No.", "PDC Application Entry"."Cust Ledger Entry No.");
                    if CustLegderEntry.FindFirst then
                        //  MESSAGE ('%1',CustLegderEntry."Remaining Amt. (LCY)");
                        CustLegderEntry.CalcFields(CustLegderEntry."Remaining Amt. (LCY)");
                    CustLegderEntry.CalcFields(CustLegderEntry."PDC Unposted Amount");
                    PendingAmount := CustLegderEntry."Remaining Amt. (LCY)" - CustLegderEntry."PDC Unposted Amount";
                end;

            }
        }
    }

    requestpage
    {


        SaveValues = false;
        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options';

                }
            }
        }

        actions
        {
        }
    }



    var
        CustLegderEntry: Record "Cust. Ledger Entry";
        PdcApplBuffer: Record "PDC Application Buffer";
        PendingAmount: Decimal;
        userSet: Record "User Setup";
        Column: Integer;
        Row: Integer;
        PrintToExcel: Boolean;
        ExcelBuf: Record "Excel Buffer";
        PDC_in_HANDCaptionLbl: label 'PDC in HAND';
        CurrReport_PAGENOCaptionLbl: label 'Page';
        CHEQUE_NOCaptionLbl: label 'CHEQUE NO';
        INVOICE_NOCaptionLbl: label 'INVOICE NO';
        INVOICE_DATECaptionLbl: label 'INVOICE DATE';
        PENDING_AMTCaptionLbl: label 'PENDING AMT';
        CHEQUE_AMTCaptionLbl: label 'CHEQUE AMT';
        PDC_REFERENCECaptionLbl: label 'PDC REFERENCE';
        DUE_DATECaptionLbl: label 'DUE DATE';
        Cheque_DateCaptionLbl: label 'Cheque Date';

    procedure EnterCell(RowNo: Integer; ColumnNo: Integer; CellValue: Text[250]; Bold: Boolean; Underline: Boolean; MergeCell: Text[30]; NumberFormat: Text[30])
    begin
    end;


}
