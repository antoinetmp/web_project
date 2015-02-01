package fr.isima.stackoverflow

import groovy.xml.MarkupBuilder;

import org.springframework.web.servlet.support.RequestContextUtils;

class LocalTagLib {
   static namespace = 'locale'
     
    List<Locale> locales = [Locale.ENGLISH, Locale.FRENCH]
 
    /**
     * Renders a locale selector.
     * Adds the class <code>active</code> to the list-element of the current language. 
     */
    def selector = {
        Locale requestLocale = RequestContextUtils.getLocale(request)
         
        MarkupBuilder mb = new MarkupBuilder(out)
		
        mb.li('class': 'dropdown') {
			mb.a ('href': '#', 'class': 'dropdown-toggle', 
				'role': 'button', 'aria-expanded': 'true', 'data-toggle': 'dropdown') {
				mb.yield message(code: 'languages.label', default: 'Languages')
				mb.span ('class': 'caret')
			}
			mb.ul('class': 'dropdown-menu', 'role': 'menu') {
				locales.each { Locale locale ->
					li(requestLocale.language == locale.language ? ['class': 'active'] : [:]) {
						mb.yield(
							link( controller: controllerName, action: actionName, params: params + [lang: locale.language],
								 { locale.getDisplayLanguage(locale) } ).toString(),
							false
							)
					}
				}
			}
        }
    }
}
