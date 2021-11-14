/**
 * @file   gpio_test.c
 * @author Derek Molloy
 * @date   19 April 2015
 * @brief  A kernel module for controlling a GPIO LED/button pair. The device mounts devices via
 * sysfs /sys/class/gpio/gpio115 and gpio49. Therefore, this test LKM circuit assumes that an LED
 * is attached to GPIO 49 which is on P9_23 and the button is attached to GPIO 115 on P9_27. There
 * is no requirement for a custom overlay, as the pins are in their default mux mode states.
 * @see http://www.derekmolloy.ie/
*/


#include <linux/init.h>
#include <linux/module.h>
#include <linux/kernel.h>
#include <linux/gpio.h>                 // Required for the GPIO functions
#include <linux/interrupt.h>            // Required for the IRQ code

MODULE_LICENSE("GPL");
MODULE_AUTHOR("Derek Molloy");
MODULE_DESCRIPTION("A Button/LED test driver for the BBB");
MODULE_VERSION("0.1");

static unsigned int gpioLED1 = 49;
static unsigned int gpioLED2 = 49;       ///< hard coding the LED gpio for this example to P9_23 (GPIO49)
static unsigned int gpioButton1 = 115;
static unsigned int gpioButton2 = 115;
static unsigned int gpioButton3 = 115;
static unsigned int gpioButton4 = 115;   ///< hard coding the button gpio for this example to P9_27 (GPIO115)
static unsigned int irqNumber1;           ///< Used to share the IRQ number within this file
static unsigned int irqNumber2;           ///< Used to share the IRQ number within this file
static unsigned int irqNumber3;           ///< Used to share the IRQ number within this file
static unsigned int irqNumber4;           ///< Used to share the IRQ number within this file
static unsigned int numberPresses = 0;  ///< For information, store the number of button presses
static bool	    ledOn = 0;          ///< Is the LED on or off? Used to invert its state (off by default)
static bool	    ledOff = 0;          ///< Is the LED on or off? Used to invert its state (off by default)

/// Function prototype for the custom IRQ handler function -- see below for the implementation
static irq_handler_t  ebbgpio_irq_handler1(unsigned int irq, void *dev_id, struct pt_regs *regs);
static irq_handler_t  ebbgpio_irq_handler2(unsigned int irq, void *dev_id, struct pt_regs *regs);
static irq_handler_t  ebbgpio_irq_handler3(unsigned int irq, void *dev_id, struct pt_regs *regs);
static irq_handler_t  ebbgpio_irq_handler4(unsigned int irq, void *dev_id, struct pt_regs *regs);

/** @brief The LKM initialization function
 *  The static keyword restricts the visibility of the function to within this C file. The __init
 *  macro means that for a built-in driver (not a LKM) the function is only used at initialization
 *  time and that it can be discarded and its memory freed up after that point. In this example this
 *  function sets up the GPIOs and the IRQ
 *  @return returns 0 if successful
 */
 static int __init ebbgpio_init(void){
    int result = 0;
    printk(KERN_INFO "GPIO_TEST: Initializing the GPIO_TEST LKM\n");
    // Is the GPIO a valid GPIO number (e.g., the BBB has 4x32 but not all available)
    if (!gpio_is_valid(gpioLED1)){
       printk(KERN_INFO "GPIO_TEST: invalid LED GPIO\n");
       return -ENODEV;
    }
    // Going to set up the LED. It is a GPIO in output mode and will be on by default
    ledOn = true;
    gpio_request(gpioLED1, "sysfs");          // gpioLED is hardcoded to 49, request it
    gpio_direction_output(gpioLED1, ledOn);   // Set the gpio to be in output mode and on
 // gpio_set_value(gpioLED, ledOn);          // Not required as set by line above (here for reference)
    gpio_export(gpioLED1, false);             // Causes gpio49 to appear in /sys/class/gpio
 			                    // the bool argument prevents the direction from being changed
    gpio_request(gpioButton1, "sysfs");       // Set up the gpioButton
    gpio_direction_input(gpioButton1);        // Set the button GPIO to be an input
    gpio_set_debounce(gpioButton1, 200);      // Debounce the button with a delay of 200ms
    gpio_export(gpioButton1, false);          // Causes gpio115 to appear in /sys/class/gpio
 			                    // the bool argument prevents the direction from being changed
    // Perform a quick test to see that the button is working as expected on LKM load
    printk(KERN_INFO "GPIO_TEST: The button state is currently: %d\n", gpio_get_value(gpioButton1));

    // GPIO numbers and IRQ numbers are not the same! This function performs the mapping for us
    irqNumber1 = gpio_to_irq(gpioButton1);
    printk(KERN_INFO "GPIO_TEST: The button is mapped to IRQ: %d\n", irqNumber1);

    // This next call requests an interrupt line
    result = request_irq(irqNumber1,             // The interrupt number requested
                         (irq_handler_t) ebbgpio_irq_handler1, // The pointer to the handler function below
                         IRQF_TRIGGER_RISING,   // Interrupt on rising edge (button press, not release)
                         "ebb_gpio_handler",    // Used in /proc/interrupts to identify the owner
                         NULL);                 // The *dev_id for shared interrupt lines, NULL is okay

    printk(KERN_INFO "GPIO_TEST: The interrupt request result is: %d\n", result);
    return result;
 }

 static int __init ebbgpio_init(void){
    int result = 0;
    printk(KERN_INFO "GPIO_TEST: Initializing the GPIO_TEST LKM\n");
    // Is the GPIO a valid GPIO number (e.g., the BBB has 4x32 but not all available)
    if (!gpio_is_valid(gpioLED2)){
       printk(KERN_INFO "GPIO_TEST: invalid LED GPIO\n");
       return -ENODEV;
    }
    // Going to set up the LED. It is a GPIO in output mode and will be on by default
    ledOff = true;
    gpio_request(gpioLED1, "sysfs");          // gpioLED is hardcoded to 49, request it
    gpio_direction_output(gpioLED1, ledOff);   // Set the gpio to be in output mode and on
 // gpio_set_value(gpioLED, ledOn);          // Not required as set by line above (here for reference)
    gpio_export(gpioLED1, false);             // Causes gpio49 to appear in /sys/class/gpio
 			                    // the bool argument prevents the direction from being changed
    gpio_request(gpioButton2, "sysfs");       // Set up the gpioButton
    gpio_direction_input(gpioButton2);        // Set the button GPIO to be an input
    gpio_set_debounce(gpioButton2, 200);      // Debounce the button with a delay of 200ms
    gpio_export(gpioButton2, false);          // Causes gpio115 to appear in /sys/class/gpio
 			                    // the bool argument prevents the direction from being changed
    // Perform a quick test to see that the button is working as expected on LKM load
    printk(KERN_INFO "GPIO_TEST: The button state is currently: %d\n", gpio_get_value(gpioButton2));

    // GPIO numbers and IRQ numbers are not the same! This function performs the mapping for us
    irqNumber2 = gpio_to_irq(gpioButton2);
    printk(KERN_INFO "GPIO_TEST: The button is mapped to IRQ: %d\n", irqNumber2);

    // This next call requests an interrupt line
    result = request_irq(irqNumber2,             // The interrupt number requested
                         (irq_handler_t) ebbgpio_irq_handler2, // The pointer to the handler function below
                         IRQF_TRIGGER_RISING,   // Interrupt on rising edge (button press, not release)
                         "ebb_gpio_handler",    // Used in /proc/interrupts to identify the owner
                         NULL);                 // The *dev_id for shared interrupt lines, NULL is okay

    printk(KERN_INFO "GPIO_TEST: The interrupt request result is: %d\n", result);
    return result;
 }

 static int __init ebbgpio_init(void){
    int result = 0;
    printk(KERN_INFO "GPIO_TEST: Initializing the GPIO_TEST LKM\n");
    // Is the GPIO a valid GPIO number (e.g., the BBB has 4x32 but not all available)
    if (!gpio_is_valid(gpioLED1)){
       printk(KERN_INFO "GPIO_TEST: invalid LED GPIO\n");
       return -ENODEV;
    }
    // Going to set up the LED. It is a GPIO in output mode and will be on by default
    ledOn = true;
    gpio_request(gpioLED2, "sysfs");          // gpioLED is hardcoded to 49, request it
    gpio_direction_output(gpioLED2, ledOn);   // Set the gpio to be in output mode and on
 // gpio_set_value(gpioLED, ledOn);          // Not required as set by line above (here for reference)
    gpio_export(gpioLED2, false);             // Causes gpio49 to appear in /sys/class/gpio
                          // the bool argument prevents the direction from being changed
    gpio_request(gpioButton3, "sysfs");       // Set up the gpioButton
    gpio_direction_input(gpioButton3);        // Set the button GPIO to be an input
    gpio_set_debounce(gpioButton3, 200);      // Debounce the button with a delay of 200ms
    gpio_export(gpioButton3, false);          // Causes gpio115 to appear in /sys/class/gpio
                          // the bool argument prevents the direction from being changed
    // Perform a quick test to see that the button is working as expected on LKM load
    printk(KERN_INFO "GPIO_TEST: The button state is currently: %d\n", gpio_get_value(gpioButton3));

    // GPIO numbers and IRQ numbers are not the same! This function performs the mapping for us
    irqNumber3 = gpio_to_irq(gpioButton3);
    printk(KERN_INFO "GPIO_TEST: The button is mapped to IRQ: %d\n", irqNumber3);

    // This next call requests an interrupt line
    result = request_irq(irqNumber3,             // The interrupt number requested
                         (irq_handler_t) ebbgpio_irq_handler3, // The pointer to the handler function below
                         IRQF_TRIGGER_RISING,   // Interrupt on rising edge (button press, not release)
                         "ebb_gpio_handler",    // Used in /proc/interrupts to identify the owner
                         NULL);                 // The *dev_id for shared interrupt lines, NULL is okay

    printk(KERN_INFO "GPIO_TEST: The interrupt request result is: %d\n", result);
    return result;
 }

 static int __init ebbgpio_init(void){
    int result = 0;
    printk(KERN_INFO "GPIO_TEST: Initializing the GPIO_TEST LKM\n");
    // Is the GPIO a valid GPIO number (e.g., the BBB has 4x32 but not all available)
    if (!gpio_is_valid(gpioLED2)){
       printk(KERN_INFO "GPIO_TEST: invalid LED GPIO\n");
       return -ENODEV;
    }
    // Going to set up the LED. It is a GPIO in output mode and will be on by default
    ledOff = true;
    gpio_request(gpioLED2, "sysfs");          // gpioLED is hardcoded to 49, request it
    gpio_direction_output(gpioLED2, ledOff);   // Set the gpio to be in output mode and on
 // gpio_set_value(gpioLED, ledOn);          // Not required as set by line above (here for reference)
    gpio_export(gpioLED2, false);             // Causes gpio49 to appear in /sys/class/gpio
 			                    // the bool argument prevents the direction from being changed
    gpio_request(gpioButton4, "sysfs");       // Set up the gpioButton
    gpio_direction_input(gpioButton4);        // Set the button GPIO to be an input
    gpio_set_debounce(gpioButton4, 200);      // Debounce the button with a delay of 200ms
    gpio_export(gpioButton4, false);          // Causes gpio115 to appear in /sys/class/gpio
 			                    // the bool argument prevents the direction from being changed
    // Perform a quick test to see that the button is working as expected on LKM load
    printk(KERN_INFO "GPIO_TEST: The button state is currently: %d\n", gpio_get_value(gpioButton4));

    // GPIO numbers and IRQ numbers are not the same! This function performs the mapping for us
    irqNumber4 = gpio_to_irq(gpioButton4);
    printk(KERN_INFO "GPIO_TEST: The button is mapped to IRQ: %d\n", irqNumber4);

    // This next call requests an interrupt line
    result = request_irq(irqNumber4,             // The interrupt number requested
                         (irq_handler_t) ebbgpio_irq_handler4, // The pointer to the handler function below
                         IRQF_TRIGGER_RISING,   // Interrupt on rising edge (button press, not release)
                         "ebb_gpio_handler",    // Used in /proc/interrupts to identify the owner
                         NULL);                 // The *dev_id for shared interrupt lines, NULL is okay

    printk(KERN_INFO "GPIO_TEST: The interrupt request result is: %d\n", result);
    return result;
 }
/** @brief The LKM cleanup function
 *  Similar to the initialization function, it is static. The __exit macro notifies that if this
 *  code is used for a built-in driver (not a LKM) that this function is not required. Used to release the
 *  GPIOs and display cleanup messages.
 */
static void __exit ebbgpio_exit1(void){
   printk(KERN_INFO "GPIO_TEST: The button state is currently: %d\n", gpio_get_value(gpioButton1));
   printk(KERN_INFO "GPIO_TEST: The button was pressed %d times\n", numberPresses);
   gpio_set_value(gpioLED1, 0);              // Turn the LED off, makes it clear the device was unloaded
   gpio_unexport(gpioLED1);                  // Unexport the LED GPIO
   free_irq(irqNumber1, NULL);               // Free the IRQ number, no *dev_id required in this case
   gpio_unexport(gpioButton1);               // Unexport the Button GPIO
   gpio_free(gpioLED1);                      // Free the LED GPIO
   gpio_free(gpioButton1);                   // Free the Button GPIO
   printk(KERN_INFO "GPIO_TEST: Goodbye from the LKM!\n");
}
static void __exit ebbgpio_exit2(void){
   printk(KERN_INFO "GPIO_TEST: The button state is currently: %d\n", gpio_get_value(gpioButton2));
   printk(KERN_INFO "GPIO_TEST: The button was pressed %d times\n", numberPresses);
   gpio_set_value(gpioLED1, 0);              // Turn the LED off, makes it clear the device was unloaded
   gpio_unexport(gpioLED1);                  // Unexport the LED GPIO
   free_irq(irqNumber2, NULL);               // Free the IRQ number, no *dev_id required in this case
   gpio_unexport(gpioButton2);               // Unexport the Button GPIO
   gpio_free(gpioLED1);                      // Free the LED GPIO
   gpio_free(gpioButton2);                   // Free the Button GPIO
   printk(KERN_INFO "GPIO_TEST: Goodbye from the LKM!\n");
}
static void __exit ebbgpio_exit3(void){
   printk(KERN_INFO "GPIO_TEST: The button state is currently: %d\n", gpio_get_value(gpioButton3));
   printk(KERN_INFO "GPIO_TEST: The button was pressed %d times\n", numberPresses);
   gpio_set_value(gpioLED2, 0);              // Turn the LED off, makes it clear the device was unloaded
   gpio_unexport(gpioLED2);                  // Unexport the LED GPIO
   free_irq(irqNumber3, NULL);               // Free the IRQ number, no *dev_id required in this case
   gpio_unexport(gpioButton3);               // Unexport the Button GPIO
   gpio_free(gpioLED2);                      // Free the LED GPIO
   gpio_free(gpioButton3);                   // Free the Button GPIO
   printk(KERN_INFO "GPIO_TEST: Goodbye from the LKM!\n");
}
static void __exit ebbgpio_exit4(void){
   printk(KERN_INFO "GPIO_TEST: The button state is currently: %d\n", gpio_get_value(gpioButton4));
   printk(KERN_INFO "GPIO_TEST: The button was pressed %d times\n", numberPresses);
   gpio_set_value(gpioLED2, 0);              // Turn the LED off, makes it clear the device was unloaded
   gpio_unexport(gpioLED2);                  // Unexport the LED GPIO
   free_irq(irqNumber4, NULL);               // Free the IRQ number, no *dev_id required in this case
   gpio_unexport(gpioButton4);               // Unexport the Button GPIO
   gpio_free(gpioLED2);                      // Free the LED GPIO
   gpio_free(gpioButton4);                   // Free the Button GPIO
   printk(KERN_INFO "GPIO_TEST: Goodbye from the LKM!\n");
}

/** @brief The GPIO IRQ Handler function
 *  This function is a custom interrupt handler that is attached to the GPIO above. The same interrupt
 *  handler cannot be invoked concurrently as the interrupt line is masked out until the function is complete.
 *  This function is static as it should not be invoked directly from outside of this file.
 *  @param irq    the IRQ number that is associated with the GPIO -- useful for logging.
 *  @param dev_id the *dev_id that is provided -- can be used to identify which device caused the interrupt
 *  Not used in this example as NULL is passed.
 *  @param regs   h/w specific register values -- only really ever used for debugging.
 *  return returns IRQ_HANDLED if successful -- should return IRQ_NONE otherwise.
 */
static irq_handler_t ebbgpio_irq_handler1(unsigned int irq, void *dev_id, struct pt_regs *regs){
   ledOn = !ledOn;                          // Invert the LED state on each button press
   gpio_set_value(gpioLED1, ledOn);          // Set the physical LED accordingly
   printk(KERN_INFO "GPIO_TEST: Interrupt! (button state is %d)\n", gpio_get_value(gpioButton1));
   numberPresses++;                         // Global counter, will be outputted when the module is unloaded
   return (irq_handler_t) IRQ_HANDLED;      // Announce that the IRQ has been handled correctly
}
static irq_handler_t ebbgpio_irq_handler2(unsigned int irq, void *dev_id, struct pt_regs *regs){
   ledOn = !ledOn;                          // Invert the LED state on each button press
   gpio_set_value(gpioLED2, ledOn);          // Set the physical LED accordingly
   printk(KERN_INFO "GPIO_TEST: Interrupt! (button state is %d)\n", gpio_get_value(gpioButton3));
   numberPresses++;                         // Global counter, will be outputted when the module is unloaded
   return (irq_handler_t) IRQ_HANDLED;      // Announce that the IRQ has been handled correctly
}
static irq_handler_t ebbgpio_irq_handler3(unsigned int irq, void *dev_id, struct pt_regs *regs){
   ledOff = !ledOff;                          // Invert the LED state on each button press
   gpio_set_value(gpioLED1, ledOff);          // Set the physical LED accordingly
   printk(KERN_INFO "GPIO_TEST: Interrupt! (button state is %d)\n", gpio_get_value(gpioButton2));
   numberPresses++;                         // Global counter, will be outputted when the module is unloaded
   return (irq_handler_t) IRQ_HANDLED;      // Announce that the IRQ has been handled correctly
}
static irq_handler_t ebbgpio_irq_handler4(unsigned int irq, void *dev_id, struct pt_regs *regs){
   ledOff = !ledOff;                          // Invert the LED state on each button press
   gpio_set_value(gpioLED2, ledOff);          // Set the physical LED accordingly
   printk(KERN_INFO "GPIO_TEST: Interrupt! (button state is %d)\n", gpio_get_value(gpioButton4));
   numberPresses++;                         // Global counter, will be outputted when the module is unloaded
   return (irq_handler_t) IRQ_HANDLED;      // Announce that the IRQ has been handled correctly
}

/// This next calls are  mandatory -- they identify the initialization function
/// and the cleanup function (as above).
module_init(ebbgpio_init);
module_exit(ebbgpio_exit1);
module_exit(ebbgpio_exit2);
module_exit(ebbgpio_exit3);
module_exit(ebbgpio_exit4);
