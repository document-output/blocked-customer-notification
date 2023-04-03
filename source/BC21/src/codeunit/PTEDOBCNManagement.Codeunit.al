codeunit 61200 "PTE DO BCN Management"
{
    [EventSubscriber(ObjectType::Table, Database::Customer, 'OnBeforeModifyEvent', '', false, false)]
    local procedure OnBeforeModifyCustomer(var Rec: Record Customer; var xRec: Record Customer; RunTrigger: Boolean)
    var
        PTEDOBCNCustomerLogfile: Record "PTE DO BCN Customer Logfile";
        EmailTemplateLine: Record "CDO E-Mail Template Line";
        EmailTemplateHeader: Record "CDO E-Mail Template Header";
        FilterRecRef: RecordRef;
        VariantRecord: Variant;
    begin
        if Rec.Blocked = xRec.Blocked then
            exit;
        EmailTemplateLine.SetRange("First Table in Report", Database::"PTE DO BCN Customer Logfile");
        //SetRange("E-Mail Template Code", 'CUST-BLOCKED-NOTIFY');
        EmailTemplateLine.SetRange(Enabled, true);
        if EmailTemplateLine.IsEmpty then
            exit;

        PTEDOBCNCustomerLogfile."Log Entry No." := 0;
        PTEDOBCNCustomerLogfile.Validate("Customer No.", Rec."No.");
        PTEDOBCNCustomerLogfile."Old Blocked Status" := xRec.Blocked;
        PTEDOBCNCustomerLogfile."New Blocked Status" := Rec.Blocked;
        PTEDOBCNCustomerLogfile."Changed by User" := UserId;
        PTEDOBCNCustomerLogfile."Changed Timestamp" := CurrentDateTime;
        PTEDOBCNCustomerLogfile.SalepersonCode := rec."Salesperson Code";
        if not PTEDOBCNCustomerLogfile.Insert(true) then
            exit;

        if EmailTemplateLine.FindFirst() then begin
            FilterRecRef.GetTable(PTEDOBCNCustomerLogfile);
            VariantRecord := PTEDOBCNCustomerLogfile;
            EmailTemplateLine.QueueMail(FilterRecRef, VariantRecord, 0, 1);
        end;

    end;
}
