using {riskmanagement as rm} from '../db/schema';

@path : 'service/risk'
service RiskService {
    @cds.redirection.target
    entity Risks       as projection on rm.Risks;

    annotate Risks with @odata.draft.enabled;
    entity Mitigations as projection on rm.Mitigations;
    annotate Mitigations with @odata.draft.enabled;
    entity ListOfRisks as projection on rm.ListOfRisks;
    entity Items       as projection on rm.Items

    // unbound actions and functions
    function getItemsByQuantity(quantity : Integer) returns array of Items;
    action   createItem(title : String, descr : String, quantity : Integer) returns Items;

// BusinessPartner will be used later
//@readonly entity BusinessPartners as projection on rm.BusinessPartners;
}
