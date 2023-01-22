(require 'org)
(require 'ox)
(require 'ox-html)

;; different postamble for different publish component is not working I have to
;; investigate this behaviour
(setq pages-html-postamble (concat "<footer> "
                                   "  <div class=\"license-container\">"
                                   "    <a rel=\"license\" href=\"http://creativecommons.org/licenses/by/4.0/\">"
                                   "    <img alt=\"Creative Commons Licence\" style=\"border-width:0; width:120px;\" src=\"https://i.creativecommons.org/l/by/4.0/88x31.png\" />"
                                   "    </a>"
                                   "  </div>"
                                   "  <div class=\"author-container\">"
                                   "    <div class=\"author\">2022 - " (format-time-string "%Y") " Francesco Pozzoni."
                                   "    </div>"
                                   "  </div>"
                                   "</footer>")

      pages-html-head (concat "<link rel=\"stylesheet\" type=\"text/css\" href=\"/assets/style.css\"/>\n"
                              "<link rel=\"shortcut icon\" href=\"assets/favicon.ico\"/>\n"
                              "<meta content=\"width=device-width, initial-scale=1\" name=\"viewport\" />\n")

      blog-html-postamble (concat "<footer>"
                                  "  <div class=\"metadata-container\">Created on: %T</div>"
                                  "  <div class=\"license-container\">"
                                  "    <a rel=\"license\" href=\"http://creativecommons.org/licenses/by/4.0/\">"
                                  "    <img alt=\"Creative Commons Licence\" style=\"border-width:0; width:120px;\" src=\"https://i.creativecommons.org/l/by/4.0/88x31.png\" />"
                                  "</a>"
                                  "  </div>"
                                  "  <div class=\"author-container\">"
                                  "    <div class=\"author\">2022 - " (format-time-string "%Y") " Francesco Pozzoni."
                                  "    </div>"
                                  "  </div>"
                                  "</footer>")

      blog-html-head (concat "<link rel=\"stylesheet\" type=\"text/css\" href=\"..//assets/style.css\"/>\n"
                             "<link rel=\"shortcut icon\" href=\"../assets/favicon.ico\"/>\n"
                             "<meta content=\"width=device-width, initial-scale=1\" name=\"viewport\" />\n"))

(setq org-html-doctype "html5"
      org-html-html5-fancy t
      org-html-head-include-scripts nil
      org-html-head-include-default-style nil
      org-html-viewport nil
      org-html-metadata-timestamp-format "%Y-%m-%d"
      org-html-htmlize-output-type 'css
      org-html-preamble (concat "<nav id=\"navbar\">"
                                "  <div id=\"navbar-inner\">"
                                "    <a href=\"/\">HOME</a> &nbsp;"
                                "    <a href=\"/blog.html\">BLOG</a>"
                                "  </div>"
                                "</nav>")
      org-html-postamble t
      org-export-with-author nil
      org-export-with-creator nil
      org-export-with-toc nil
      org-export-with-section-numbers nil
      org-publish-timestamp-directory (convert-standard-filename "./.org-timestamps/")
      org-src-fontify-natively t)


;; Thanks to Thomas Ingram I found this in this email thread
;; https://lists.gnu.org/archive/html/emacs-orgmode/2019-07/msg00060.html
(setq org-export-global-macros
      '(("div" . "@@html:<div class=\"timestamp\">$1</div>@@")))

(defun org-sitemap-custom-entry-format (entry style project)
  "Sitemap entry format that includes date."
  (let ((filename (org-publish-find-title entry project)))
    (if (= (length filename) 0)
        (format "*%s*" entry)
      (format "[[file:%s][%s]] {{{div(%s)}}}"
              entry
              filename
              (format-time-string "%Y-%m-%d"
                  (org-publish-find-date entry project))
              ))))

(setq org-publish-project-alist
      `(("pages"
         :html-head ,pages-html-head
         :html-postamble ,pages-html-postamble
         :base-directory "."
         :base-extension "org"
         :publishing-directory "docs/"
         :publishing-function org-html-publish-to-html
         :recursive t)
        ("blog"
         :html-head ,blog-html-head
         :html-postamble ,blog-html-postamble
         :base-directory "blog/"
         :base-extension "org"
         :publishing-directory "docs/blog/"
         :publishing-function org-html-publish-to-html
         :recursive t
         :auto-sitemap t
         :sitemap-filename "sitemap.org"
         :sitemap-format-entry org-sitemap-custom-entry-format
         :sitemap-sort-files anti-chronologically)
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
        ("all" :components ("blog" "pages" "blog-images" "assets"))))
