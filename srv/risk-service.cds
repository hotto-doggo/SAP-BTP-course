using {riskmanagement as rm} from '../db/schema';

@path: 'service/risk'
service RiskService {
    @cds.redirection.target
    entity Risks @(restrict: [
        {
            grant: 'READ',
            to   : 'RiskViewer'
        },
        {
            grant: [
                'READ',
                'WRITE',
                'UPDATE',
                'UPSERT',
                'DELETE'
            ], // Allowing CDS events by explicitly mentioning them
            to   : 'RiskManager'
        }
    ])                      as projection on rm.Risks;

    annotate Risks with @odata.draft.enabled;

    entity Mitigations @(restrict: [
        {
            grant: 'READ',
            to   : 'RiskViewer'
        },
        {
            grant: '*', // Allow everything using wildcard
            to   : 'RiskManager'
        }
    ])                      as projection on rm.Mitigations;

    annotate Mitigations with @odata.draft.enabled;

    // BusinessPartner will be used later
    @readonly
    entity BusinessPartners as projection on rm.BusinessPartners;

    entity ListOfRisks      as projection on rm.ListOfRisks;
    entity Items            as projection on rm.Items;
    // unbound actions and functions
    function getItemsByQuantity(quantity : Integer)                         returns array of Items;
    action   createItem(title : String, descr : String, quantity : Integer) returns Items;
}
