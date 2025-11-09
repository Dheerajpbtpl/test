// Table 465 "Additional Approvers"
// {
//     Caption = 'Additional Approvers';

//     fields
//     {
//         field(1; "Approval Code"; Code[20])
//         {
//             Caption = 'Approval Code';
//             TableRelation = "Approval Templates"."Approval Code";
//         }
//         field(2; "Approver ID"; Code[50])
//         {
//             Caption = 'Approver ID';
//             TableRelation = "User Setup"."User ID";

//             trigger OnValidate()
//             var
//                 AddAppr: Record "Additional Approvers";
//                 ApprTemplate: Record "Approval Templates";
//             begin
//                 AddAppr.SetRange("Approval Code", "Approval Code");
//                 AddAppr.SetRange("Approval Type", "Approval Type");
//                 AddAppr.SetRange("Document Type", "Document Type");
//                 AddAppr.SetRange("Limit Type", "Limit Type");
//                 if "Approver ID" <> '' then begin
//                     AddAppr.SetRange("Approver ID", "Approver ID");
//                     if AddAppr.FindFirst then
//                         Error(StrSubstNo(Text001, AddAppr."Approver ID"));
//                 end else begin
//                     AddAppr.SetFilter("Approver ID", '<>%1&<>%2', '', xRec."Approver ID");
//                     if not AddAppr.FindFirst then
//                         if ApprTemplate.Get("Approval Code", "Approval Type", "Document Type", "Limit Type") then
//                             if ((ApprTemplate."Approval Type" = ApprTemplate."approval type"::" ") or
//                                 (ApprTemplate."Limit Type" = ApprTemplate."limit type"::"Credit Limits")) and ApprTemplate.Enabled
//                             then
//                                 if Confirm(StrSubstNo(Text002, AddAppr.TableCaption)) then begin
//                                     ApprTemplate.Validate(Enabled, false);
//                                     ApprTemplate.Modify;
//                                 end else
//                                     Error('');
//                 end;
//             end;
//         }
//         field(3; "Approval Type"; Option)
//         {
//             Caption = 'Approval Type';
//             OptionCaption = ' ,Sales Pers./Purchaser,Approver';
//             OptionMembers = " ","Sales Pers./Purchaser",Approver;
//         }
//         field(4; "Document Type"; Option)
//         {
//             Caption = 'Document Type';
//             OptionCaption = 'Quote,Order,Invoice,Credit Memo,Blanket Order,Return Order,None,Item Journal';
//             OptionMembers = Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None","Item Journal";
//         }
//         field(5; "Limit Type"; Option)
//         {
//             Caption = 'Limit Type';
//             Editable = false;
//             OptionCaption = 'Approval Limits,Credit Limits,Request Limits,No Limits';
//             OptionMembers = "Approval Limits","Credit Limits","Request Limits","No Limits";
//         }
//         field(6; "Sequence No."; Integer)
//         {
//             Caption = 'Sequence No.';
//             Editable = false;
//         }
//     }

//     keys
//     {
//         key(Key1; "Approver ID", "Approval Code", "Approval Type", "Document Type", "Limit Type", "Sequence No.")
//         {
//             Clustered = true;
//         }
//         key(Key2; "Sequence No.")
//         {
//         }
//     }

//     fieldgroups
//     {
//     }

//     trigger OnDelete()
//     var
//         AddAppr: Record "Additional Approvers";
//         ApprTemplate: Record "Approval Templates";
//     begin
//         AddAppr.SetRange("Approval Code", "Approval Code");
//         AddAppr.SetRange("Approval Type", "Approval Type");
//         AddAppr.SetRange("Document Type", "Document Type");
//         AddAppr.SetRange("Limit Type", "Limit Type");
//         AddAppr.SetFilter("Approver ID", '<>%1&<>%2', '', "Approver ID");
//         if not AddAppr.FindFirst then
//             if ApprTemplate.Get("Approval Code", "Approval Type", "Document Type", "Limit Type") then
//                 if ((ApprTemplate."Approval Type" = ApprTemplate."approval type"::" ") or
//                     (ApprTemplate."Limit Type" = ApprTemplate."limit type"::"Credit Limits")) and ApprTemplate.Enabled
//                 then
//                     if Confirm(StrSubstNo(Text002, AddAppr.TableCaption)) then begin
//                         ApprTemplate.Validate(Enabled, false);
//                         ApprTemplate.Modify;
//                     end else
//                         Error('');
//     end;

//     var
//         Text001: label 'Approver ID %1 is already an additional approver on this template.';
//         Text002: label 'The approval template will be disabled because no %1 are available.\Do you want to continue?';
// }

