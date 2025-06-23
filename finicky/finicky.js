export default {
  defaultBrowser: "Safari",
  handlers: [
    //{
    //    // Open pdfs in Safari
    //    match: [
    //        /.pdf/,
    //    ],
    //    browser: "Safari"
    //},
  	{
   		// Open Outlook safeURL links to Office365 or Workplace sites in Firefox
    	match: [
    		/norwegianrefugeecouncil.sharepoint.com/,
            /https:\/\/url[0-9].mailanyone.net/,
	    	/norwegianrefugeecouncil-my.sharepoint.com/,
	    	/norcap.workplace.com/,
            /eu.docusign.net/,
            /cloud.microsoft/,
            /whiteboard.office.com/,
            /^https:\/\/forms.office.com/,
            /^https:\/\/app.powerbi.com/,
            /u4a.se/,
            /gorsdev.nrc.no/,
            /gors.nrc.no/,
            /apps.powerapps.com/,
    	],
    	browser: "Firefox"
  	},
  ]
};
