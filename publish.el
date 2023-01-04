(package-initialize)

(require 'org)
(require 'ox)
(require 'ox-html)

(setq org-publish-timestamp-directory (convert-standard-filename "./.org-timestamps/")
      org-src-fontify-natively t)
(setq org-html-htmlize-output-type 'css)

(setq org-html-preamble "<nav id=\"navbar\">
  <div id=\"navbar-inner\">
    <a href=\"/\">HOME</a> &nbsp;
    <a href=\"/blog.html\">BLOG</a>
  </div>
</nav>"
      org-html-postamble (concat "<footer>
  <div class=\"license-container\">
    <a rel=\"license\" href=\"http://creativecommons.org/licenses/by/4.0/\">
    <img alt=\"Creative Commons Licence\" style=\"border-width:0; width:120px;\" src=\"https://i.creativecommons.org/l/by/4.0/88x31.png\" /></a>
  </div>
  <div class=\"author-container\">
    <div class=\"author\">2022, " (format-time-string "%Y") " Francesco Pozzoni.
    </div>
  </div>
</footer>"))

(setq org-publish-project-alist
      '(("pages"
         ;; html5
         :html-doctype "html5"
         :html-html5-fancy t
         ;; disable org default style and scripts
         :html-head-include-scripts nil
         :html-head-include-default-style nil
         :html-viewport nil
         ;; style.css link
         :html-head "<link rel=\"stylesheet\" type=\"text/css\" href=\"assets/style.css\"/>\n<link rel=\"shortcut icon\" href=\"assets/favicon.ico\"/>
<meta content=\"width=device-width, initial-scale=1\" name=\"viewport\" />"
         ;; no info on pages
         :with-author nil
         :with-creators nil
         :with-date nil
         :with-creator nil
         :with-toc nil
         :section-numbers nil
         :base-directory "."
         :base-extension "org"
         :publishing-directory "docs/"
         :publishing-function org-html-publish-to-html
         :recursive t)
        ("blog";
         ;; html5
         :html-doctype "html5"
         :html-html5-fancy t
         ;; disable org default style and scripts
         :html-head-include-scripts nil
         :html-head-include-default-style nil
         :html-viewport nil
         :with-toc nil
         :section-numbers nil
         :html-head "<link rel=\"stylesheet\" type=\"text/css\" href=\"../assets/style.css\"/>\n<link rel=\"shortcut icon\" href=\"../assets/favicon.ico\"/>
<meta content=\"width=device-width, initial-scale=1\" name=\"viewport\" />"
         :base-directory "blog/"
         :base-extension "org"
         :publishing-directory "docs/blog/"
         :publishing-function org-html-publish-to-html
         :auto-sitemap t
         :recursive t
         :sitemap-filename "sitemap.org")
        ("blog-images"
         :base-directory "blog/"
         :base-extension "jpg\\|gif\\|png"
         :publishing-directory "docs/blog"
         :publishing-function org-publish-attachment
         :recursive t)
        ("assets"
         :base-directory "assets/"
         :base-extension "css\\|ttf\\|ico\\|png"
         :publishing-directory "docs/assets/"
         :publishing-function org-publish-attachment
         :recursive t)
        ("all" :components ("pages" "blog" "blog-images" "assets"))))
