package arena.components

import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.arena.layout.HorizontalLayout
import org.uqbar.arena.widgets.Container
import org.uqbar.arena.widgets.Label
import org.uqbar.arena.widgets.Panel
import org.uqbar.arena.widgets.Widget

@Accessors
abstract class AbstractLabeledWidget extends Panel {

	Label label
	
	new(Container container) {
		super(container)
		layout = new HorizontalLayout
		label = new Label(this)
		createWidget(this) 
	}
	
	def AbstractLabeledWidget setText(String text){ 
		label.text = text
		this
	}
	
	def Widget createWidget(AbstractLabeledWidget widget)
	
	def AbstractLabeledWidget bindValueToProperty(String property)
		
}
