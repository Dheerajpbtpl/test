/// <summary>
/// Report Customer Statement 21 old (ID 51006).
/// </summary>
///Taneesh
Report 51006 "Customer Statement 21 old"
{
    RDLCLayout = './Layouts/CustomerStatement21old.rdlc';
    DefaultLayout = RDLC;

    dataset
    {
        dataitem(Customer; Customer)
        {
            RequestFilterFields = "No.";
            column(CmpName; CmpInfo.Name)
            {
            }
            column(CmpAddr; CmpInfo.Address)
            {
            }
            column(CmpAddr2; CmpInfo."Address 2")
            {
            }
            column(CmpCity; CmpInfo.City)
            {
            }
            column(CmpPhone; CmpInfo."Phone No.")
            {
            }
            column(CmpPhone2; CmpInfo."Phone No. 2")
            {
            }
            column(CmpMail; CmpInfo."E-Mail")
            {
            }
            column(CmpPostCode; CmpInfo."Post Code")
            {
            }
            column(CmpCountry; CmpInfo.County)
            {
            }
            column(CmpTinNo; ' CmpInfo."T.I.N. No."')
            {
            }
            column(CmpPanNo; CmpInfo."P.A.N. No.")
            {
            }
            column(CmpPicture; CmpInfo.Picture)
            {
            }
            column(Cust_No; Customer."No.")
            {
            }
            column(Cust_Name; Customer.Name)
            {
            }
            column(Cust_Addr; Customer.Address)
            {
            }
            column(Cust_Addr2; Customer."Address 2")
            {
            }
            column(Cust_Addr3; Customer."address 3")
            {
            }
            column(Cust_City; Customer.City)
            {
            }
            column(Cust_Post_Code; Customer."Post Code")
            {
            }
            column(Cust_Country; Customer.County)
            {
            }
            column(Cust_Contact; Customer.Contact)
            {
            }
            column(Cust_Phone; Customer."Phone No.")
            {
            }
            column(Cust_Mob2; '')
            {
            }
            column(Cust_Email; Customer."E-Mail")
            {
            }
            column(Cust_Mail2; '')
            {
            }
            column(Cust_TinNo; 'Customer."T.I.N. No."')
            {
            }
            column(Cust_Pan; Customer."P.A.N. No.")
            {
            }
            column(CustOpAmt; CustOpAmt)
            {
            }
            dataitem("Cust. Ledger Entry"; "Cust. Ledger Entry")
            {
                CalcFields = "Debit Amount", "Credit Amount", Amount;
                DataItemLink = "Customer No." = field("No.");
                column(LedEntryNo; "Cust. Ledger Entry"."Entry No.")
                {
                }
                column(Posting_Date; Format("Cust. Ledger Entry"."Posting Date"))
                {
                }
                column(Doct_Type; DoctType)
                {
                }
                column(Doct_No; "Cust. Ledger Entry"."Document No.")
                {
                }
                column(Doct_Desc; "Cust. Ledger Entry".Description)
                {
                }
                column(SalesPerson; "Cust. Ledger Entry"."Salesperson Code")
                {
                }
                column(UserIdCrBy; "Cust. Ledger Entry"."User ID")
                {
                }
                column(DueDate; Format("Cust. Ledger Entry"."Due Date"))
                {
                }
                column(Amount; "Cust. Ledger Entry".Amount)
                {
                }
                column(RunningAmt; RunningAmt)
                {
                }
                column(DrAmt; DrAmt)
                {
                }
                column(CrAmt; CrAmt)
                {
                }
                column(AmtToWords; NoText[1])
                {
                }
                column(CurrencyCode_CustLedgerEntry; "Cust. Ledger Entry"."Currency Code")
                {
                }
                column(Narrationtext; Narrationtext)
                {
                }
                column(CustOpAmt2; CustOpAmt)
                {
                }
                trigger OnPreDataItem();
                begin
                    "Cust. Ledger Entry".SetRange("Cust. Ledger Entry"."Posting Date", StartDate, EndDate);
                    RunningAmt := CustOpAmt;
                    //"Cust. Ledger Entry".SETCURRENTKEY("Cust. Ledger Entry"."Posting Date");
                end;

                trigger OnAfterGetRecord();
                begin
                    //Currency.GET;
                    DrAmt := 0;
                    CrAmt := 0;
                    "Cust. Ledger Entry".CalcFields("Cust. Ledger Entry".Amount);
                    Narrationtext := '';
                    PostedNarration.Reset;
                    PostedNarration.SetRange("Entry No.", 0);
                    PostedNarration.SetRange("Transaction No.", "Transaction No.");
                    if PostedNarration.FindFirst then
                        Narrationtext := PostedNarration.Narration;
                    if "Cust. Ledger Entry".Amount >= 0 then
                        DrAmt := "Cust. Ledger Entry".Amount
                    else
                        CrAmt := "Cust. Ledger Entry".Amount;
                    RunningAmt := RunningAmt + DrAmt + CrAmt;
                    if Format("Cust. Ledger Entry"."Document Type") = '' then
                        DoctType := 'Journal'
                    else
                        DoctType := Format("Cust. Ledger Entry"."Document Type");
                    AmtToWords.InitTextVariable;
                    AmtToWords.FormatNoText(NoText, Abs(RunningAmt), Currency.Code);
                end;

                trigger OnPostDataItem();
                begin
                    if (SendMail = true) and (counter = 0) then begin
                        Clear(CustomerStatement);
                        FileName := '';
                        Date := DelChr(Format(Today), '=', '/-');
                        TimeT := DelChr(Format(Time), '=', ':');
                        FileName := 'E:\Perfoma Invoice PBTPL\Customer Statement ' + TimeT + Date + '.pdf';
                        //MESSAGE(FORMAT(counter+1));
                        CustomerStatement.SetData(StartDate, EndDate, CustNo, (counter + 1));
                        CustomerStatement.SaveAsPdf(FileName);
                        //  SMTPSetup.Get();
                        CompInfo.Get;
                        Body :=
                        'Dear ' + 'Sir' + ',' + '<br>' +
                        '<br>' +
                      '<br>' +
                          'Please find the Customer Statement as on ' + Format(StartDate) + ' to ' + Format(EndDate) + '<br>' +
                          '<br>' +
                          'This is a System Generateed Mail by Microsoft Dynamics Navision, Please do not reply.' + '<br>' +
                          '<br>' +
                        'Regards' + '<br>' +
                        CompInfo.Name + '<BR>';
                        // SMTPMail.CreateMessage(SMTPSetup."Email Sender Name", SMTPSetup."Sender Email ID", 'dheeraj@punjabbulls.com', 'Account Statement of' + ' ' + Customer.Name + ' ' + Format(StartDate) + ' to ' + Format(EndDate), Body, true);
                        //  SMTPMail.AddAttachment(FileName, '');
                        //SMTPMail.AddRecipients('dheeraj@punjabbulls.com');
                        //SMTPMail.Send;
                        //Customer."E-Mail"
                        Message('Mail Sent');
                    end;
                end;

            }
            trigger OnPreDataItem();
            begin
                Customer.SetRange(Customer."No.", CustNo);
                CmpInfo.Get;
                CmpInfo.CalcFields(CmpInfo.Picture);
            end;

            trigger OnAfterGetRecord();
            begin
                CustOpAmt := 0;
                RunningAmt := 0;
                DetCustLedEnt.Reset;
                DetCustLedEnt.SetRange(DetCustLedEnt."Customer No.", Customer."No.");
                DetCustLedEnt.SetRange(DetCustLedEnt."Posting Date", 0D, StartDate - 1);
                DetCustLedEnt.CalcSums(DetCustLedEnt.Amount);
                CustOpAmt := DetCustLedEnt.Amount;
            end;

        }
    }

    requestpage
    {

        SaveValues = true;

        layout
        {
            area(content)
            {
                field(Customer; CustNo)
                {
                    ApplicationArea = Basic;
                    TableRelation = Customer."No.";
                }
                field("Start Date"; StartDate)
                {
                    ApplicationArea = Basic;
                }
                field("End Date"; EndDate)
                {
                    ApplicationArea = Basic;
                }
                field("Send Mail"; SendMail)
                {
                    ApplicationArea = Basic;
                }

            }
        }

        actions
        {
        }
    }


    var
        StartDate: Date;
        EndDate: Date;
        DetCustLedEnt: Record "Detailed Cust. Ledg. Entry";
        CustOpAmt: Decimal;
        RunningAmt: Decimal;
        CmpInfo: Record "Company Information";
        CustNo: Code[10];
        DrAmt: Decimal;
        CrAmt: Decimal;
        DoctType: Text;
        AmtToWords: Report Check;
        NoText: array[2] of Text;
        Currency: Record Currency;
        SendMail: Boolean;
        CustomerStatement: Report "Customer Statement 21";
        FileName: Text;
        Date: Text;
        TimeT: Text;
        //SMTPSetup: Record "SMTP Mail Setup";
        CompInfo: Record "Company Information";
        Body: Text;
        //SMTPMail: Codeunit "SMTP Mail";
        counter: Integer;
        PostedNarration: Record "Posted Narration";
        Narrationtext: Text;

    procedure SetData(StartDate1: Date; EndDate1: Date; CustomerNo1: Text; Counter1: Integer)
    begin
        StartDate := StartDate1;
        EndDate := EndDate1;
        CustNo := CustomerNo1;
        counter := Counter1;
    end;


}
