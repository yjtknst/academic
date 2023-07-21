;; Set the package installation directory so that packages aren't stored in the
;; ~/.emacs.d/elpa path.
(require 'package)
(setq package-user-dir (expand-file-name "./.packages"))
(setq package-archives '(("melpa" . "https://melpa.org/packages/")
                         ("elpa" . "https://elpa.gnu.org/packages/")))

(package-initialize)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(add-to-list 'package-archives '("elpa" . "https://elpa.gnu.org/packages/") t)
(package-refresh-contents)

(unless (package-installed-p 'use-package)
  (package-install 'use-package))
(require 'use-package)

;; Install dependencies
(use-package esxml :ensure t)
(use-package htmlize :ensure t)
(use-package webfeeder :ensure t)


;; load the citation processing system
(use-package citeproc :ensure t)
(require 'oc-csl)

;; Load the publishing system
(require 'ox-publish)

;; Customize the HTML output
(setq user-full-name "yjtknst")
(setq org-html-validation-link nil
      org-html-htmlize-output-type 'css
      ;; Don't show validation link
      ;; org-html-head-include-scripts nil       ;; Use our own scripts
      org-html-head-include-default-style nil ;; Use our own styles
      org-html-head "<link rel=\"stylesheet\" href=\"https://gongzhitaao.org/orgcss/org.css\" />")

;; bibliography
(setq bib-name (list (file-truename "../../01-bib/references.bib")))
(setq org-cite-global-bibliography bib-name)
(setq org-cite-csl-styles-dir (file-truename "../../01-bib/csl/"))

;; Define the publishing project
(setq org-publish-project-alist
      (list
       (list
	"org"
	:recursive t
        :base-directory "./org-src"
	:base-extension "org"
        :publishing-function 'org-html-publish-to-html
        :publishing-directory "./public"
        :with-author t           ;; Don't include author name
        :with-creator t            ;; Include Emacs and Org versions in footer
        :with-toc t                ;; Include a table of contents
        :section-numbers nil       ;; Don't include section numbers
        :time-stamp-file nil)
       (list
	"static"
	:recursive t
	:base-directory "./content"
	:base-extension "css\\|js\\|png\\|jpg\\|gif\\|pdf\\|mp3\\|mp4"
	:publishing-function 'org-publish-attachment
	:publishing-directory "./public")
       (list
	"site"
	:components '("org" "static"))))

;; no backup files
(setq make-backup-files nil)

;; Generate the site output
(org-publish-all t)

(message "Build complete!")
