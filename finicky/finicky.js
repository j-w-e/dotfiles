export default {
    defaultBrowser: "Safari",
    rewrite: [
        {
            // Redirect all x.com urls to use xcancel.com
            match: [
                "x.com/*",
                "twitter.com/*",
            ],
            url: (url) => {
                url.host = "xcancel.com";
                return url;
            },
        },
    ],
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
                /https:\/\/url[0-9]+.mailanyone.net/,
                /norwegianrefugeecouncil.sharepoint.com/,
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
                /app.sharegate.com/,
            ],
            browser: "Firefox"
        },
    ]
};
