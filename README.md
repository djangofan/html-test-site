StaticHTMLTestSite
==================

A static sample HTML site for WebDriver testing.  Site browsing is not enabled; you <br/>
will need to hit the exact URL:  [http://localhost:8001/index.html](http://localhost:8001/index.html)

Get up and running with three steps:
      1. Download the .zip distribution of this archive. Unzip it anywhere.</li>
      2. Run with Gradle tasks "clean copyToLib compileJava".  There is also a<br/>
         'startWeb' Gradle task if  you choose to use it but it isn't really necessary.</li>
      3. Run the included 'startWeb.bat' directly. (startWeb.sh coming soon)</li>


GitHub Site URL
==================
http://djangofan.github.com/html-test-site

Project Demo
==================
http://djangofan.github.com/html-test-site/site/index.html


Originally forked from this project:
==================
https://github.com/pojorisin


Instructions For Forking This Project
==================

Steps to publishing a website on GitHub:

    Fork my project at GitHub: https://github.com/djangofan/html-test-site
    CD C:\Temp
    git clone https://github.com/djangofan/html-test-site.git
    CD C:\Temp\html-test-site
    git checkout --orphan gh-pages
    git rm -rf .
    cp -r C:\Eclipse\workspace\html-test-site\site C:\Temp\html-test-site\site
    The Eclipse directory is a copy of the master branch on my local machine.
    git add .
    git commit -a -m "Initial gh-pages commit."
    git pull origin gh-pages
    git push origin gh-pages
    Wait a few minutes and access at: http://ACCTNAME.github.com/html-test-site/site/index.html

NOTE: What you end up with is a master branch and a gh-pages branch in your source control. If you delete<br/>
the gh-pages branch from GitHub then the site pages will disappear a few minutes later.

To update the branch, these are the steps:

    CD C:\Temp\html-test-site
    git checkout origin gh-pages
    Make edits
    git add .
    git commit -a -m "Initial gh-pages commit."
    git pull origin gh-pages
    git push origin gh-pages
    Wait a few minutes and access at: http://ACCTNAME.github.com/html-test-site/site/index.html

