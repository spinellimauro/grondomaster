package arena.components

import org.uqbar.arena.widgets.Container
import org.uqbar.arena.widgets.TextBox

class LabeledTextBox extends AbstractLabeledWidget {
	
	TextBox textBox
	
	new(Container container) {
		super(container)
		label.fontSize = 12
		textBox.fontSize = 10
	}
	
	override LabeledTextBox setWidth(int ancho){
		textBox.width = ancho
		this 
	}
	
	override createWidget(AbstractLabeledWidget widget) {
		textBox = new TextBox(this)
		this
	}
	
	override bindValueToProperty(String property) {
		textBox.bindValueToProperty(property)
		this
	}
	
	def setEnabled (String property){
		textBox.bindEnabledToProperty(property)
		this
	}
	
	def void bindTextToProperty(String property) {
		label.bindValueToProperty(property)
	}
	
}
