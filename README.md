html-test-site
==================

A static sample HTML site for WebDriver testing.  Hosted on GitHub at this location:

[http://djangofan.github.com/html-test-site/site/index.html](http://djangofan.github.com/html-test-site/site/index.html)


Alternatively, you can get it up and running on your own local system with three steps:

    1. Download the .zip distribution of this archive. Unzip it anywhere.
    2. Run with Gradle tasks "clean copyToLib compileJava".  There is also a 'startWeb' Gradle task if you choose
       to use it but it isn't really necessary.
    3. Run the included 'startWeb.bat' directly. (startWeb.sh coming soon)
    4. Navigate to http://localhost:8001/index.html


GitHub Page URL
==================
http://djangofan.github.com/html-test-site


Originally forked from this project:
==================
https://github.com/pojorisin


Instructions On Forking This Project For Yourself
==================

Steps to publishing a website on GitHub (each line is a separate step):

    Fork my project at GitHub: https://github.com/djangofan/html-test-site
    CD C:\Temp
    git clone https://github.com/djangofan/html-test-site.git
    CD C:\Temp\html-test-site
    git checkout --orphan gh-pages
    git rm -rf .
    Copy updated site files into place, within C:\Temp\html-test-site\site
    git add .
    git commit -a -m "Initial gh-pages commit."
    git pull origin gh-pages
    git push origin gh-pages
    Wait a few minutes and access at: http://ACCTNAME.github.com/html-test-site/site/index.html

NOTE: What you end up with is a master branch and a gh-pages branch in your source control. If you delete<br/>
the gh-pages branch from GitHub then the site pages will disappear a few minutes later.

To update the branch, these are the steps:

    CD C:\Temp\html-test-site
    git checkout gh-pages
    Make edits
    git add .
    git config --global user.email "you@examplecom"
    git config --global user.name "Your Name"
    git commit -a -m "Initial gh-pages commit."
    git pull origin gh-pages
    git push origin gh-pages
    Wait a few minutes and access at: http://ACCTNAME.github.com/html-test-site/site/index.html

