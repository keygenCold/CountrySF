# CountrySF
Country Salesforce API
Classes:			CodeCoverage

CountryService			89% 
CountryServiceTest		
LeadCountryTriggerTest
CountryScheduler                100%
CountrySchedulerTest             
ExternalApiConfigHelper		100%
ExternalApiConfigHelperTest
CountryServiceMock
CountryServiceMock_Failure
MockHttpResponseGenerator

Triggers:
	
	LeadCountryTrigger	100%
Flow:
	Lead_Flow


Object:
	Country__c (custom)
	FIELDS:
		Alpha-2 Code	Alpha2__c	Text(2)		False	
		Alpha-3 Code	Alpha3__c	Text(3)		False	
		Capital	Capital__c	Text(80)		False	
		Country Name	Name	Text(80)		True	
		Created By	CreatedById	Lookup(User)		False	
		Last Modified By	LastModifiedById	Lookup(User)		False	
		Owner	OwnerId	Lookup(User,Group)		True	
		Region	Region__c	Text(80)		False	
		Regional Blocs	RegionalBlocs__c	Text(80) (i cannot retrieve it because it isnt retrieved on the APICall)

	Lead__c	(added new fields)
	FIELDS:
		Alpha2	Alpha2__c	Text(2)	False	
		Alpha3	Alpha3__c	Text(3)
		Country	Country__c	Text(128)
		Owner_Since	Owner_Since__c	Date/Time
		Region	Region__c	Text(80)	False	
		RegionalBlocs	RegionalBlocs__c Text(128) (i cannot retrieve it because it isnt retrieved on the APICall)

Validation Rule on Lead Object
	Prevent_Lead_Owner_Change
Custom Permissions
		Admin_No_Validation
		Contract_Manager_No_Validation
Custom MetadataType:
		External API Config External_API_Config__mdt


Post step deploy: 

	add the permission set to the users that need to see the object Countries.
	add the tab Countries to the sales app in the navigation items 
	activate the batch in the anonymous console with System.schedule('Daily Country Sync', '0 0 0 * * ?', new CountryScheduler()); (the default is scheduled to the midnight).

TIP Terminal command used for package deploy deploy:
sfdx force:source:deploy --manifest manifest/package.xml --testlevel RunLocalTests
